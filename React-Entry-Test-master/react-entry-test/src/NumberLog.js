import React from 'react';

class NumberLog extends React.Component {

    render() {
        return  (
            
            <textarea id="textarea" name="textarea" rows="10" cols="100" readOnly value={this.props.log.map((logItem) => (
                logItem.comment + '\n'
           )).join('')}
           />
        )
    }
}

export default NumberLog; 