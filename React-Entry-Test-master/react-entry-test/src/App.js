/*
For this piece of the test, you will have a several CSS and ReactJS questions.

ReactJS
  1. Fill in your name and the date in the "By" line. 
  2. Add a Function to be called when the Random Number is clicked to change the Number Header State
  3. The random number needs to be between 0 and 100 and showing no decimals 
  4. Add to the log text area saying "Random Number to " and then the new number generated on a new line.  
  5. Add a Function to be called when the Increment Number is clicked to change the Number Header State
  6. If the number will be above 100 (an increment from 100 to 101) display an error stating that the maximum numver is 100 
  7. Add to the log text area saying "Incremented Number to " and then the new number generated on a new line.  
  8. Add a text area for the log state that is 10 rows in height and 100 in width. 
  9. Make sure when each button is click, they are visible in the log and each is on a different line. Wording for this is in #4 and #7.

CSS
  For the CSS portion, getting the basics is the most important which will be listed below, however if you consider yourself a web designer and want to do more than the list, please do. 

  1. Style the buttons to any extent you want to
  2. Add an image to the background that still allows you to read everything. 
  3. If the number is greater than or equal to 50, then the number header needs to be a red. If the number is below 50, then the number header needs to be a blue. 
*/


import React from 'react';
import './App.css';
import NumberLog from './NumberLog';

class App extends React.Component {

  constructor() {
    super();
    this.state = {
      numberHeader: 0,
      log: [
        {
          comment: "Started logging at 0"
        }
      ]
    };
  }

  //function that produces a random number to be reflected in the number header
  getRandomNumber = () => {
    const min = 1;
    const max = 100;
    const randomNum = Math.round(min + Math.random() * (max - min));
    this.setState({ numberHeader: randomNum });
    const newItem = {
      comment: "Random Number to "+ randomNum
    }
    this.setState({ log: [ ...this.state.log, newItem ] });
  }

  //function that increments the current number header value 
  incrementNumber = () => {
    const newNum = this.state.numberHeader + 1;
    this.setState({ numberHeader: newNum });

    //display error if number exceeds 100
    if ( newNum > 100 ) {
      alert('Error: The maximum number allowed is 100.');
    }

    const newItem = {
      comment: "Incremented Number to "+ newNum,
    }
    this.setState({ log: [ ...this.state.log, newItem ] });
  }

  //make number header red if >= 50 & blue if <= 50
  getStyle = () => {
    let num = this.state.numberHeader;
    if(num >= 50) {
      return { color: 'red' }
    } else if(num <= 50) {
      return { color: 'blue' }
    }
  }


// Add a Function to be called when the Random Number is clicked to change the Number Header State
// The random number needs to be between 0 and 100 and showing no decimals 
// Add to the log text area saying "Random Number to " and then the new number generated on a new line.  

// Add a Function to be called when the Increment Number is clicked to change the Number Header State
// If the number will be above 100 (an increment from 100 to 101) display an error stating that the maximum number is 100 
// Add to the log text area saying "Incremented Number to " and then the new number generated on a new line.  

// If the number is greater than or equal to 50, then the number header needs to be a red. If the number is below 50, then the number header needs to be a blue. 

  render() {
    return (
      <div className="App">
          <h1 id="num-header" style={this.getStyle()}>{this.state.numberHeader}</h1>
          <button className="btn" onClick={this.getRandomNumber}> Random Number</button> &nbsp;
          <button className="btn" onClick={this.incrementNumber}> Increment Number</button>
          <br></br>
          <br></br>
          {/* Add a text area for the log: */}
          <NumberLog log={this.state.log} />
          <p> By: Marie Kelling - 2/22/2020</p>
          <p>	&#169; 2020 World Shipping, Inc.</p>
      </div>
    );
  }
}

export default App;