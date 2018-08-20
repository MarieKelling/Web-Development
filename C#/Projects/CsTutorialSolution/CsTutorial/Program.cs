using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CsTutorial
{
    class Program
    {
        static void Main(string[] args)
        {
            Shape[] shapes = { new Circle(5), new Rectangle(4, 5) }; 

            foreach (Shape s in shapes)
            {
                s.GetInfo();
                Console.WriteLine("{0} Area : {1}", s.Name, s.Area());
            }

            /* Console.WriteLine("Hello World!");             //Simple 'Hello World' display
            Console.ReadLine();

            SayHello();
            PromptStrings();
            PromptUserInput(); */

            Console.WriteLine("Press any key exit..."); 
            Console.ReadKey(); 
        }

        private static void SayHello()
        {
            string name;                                //Declare local var
            Console.Write("Enter your first name: ");   //Prompt user for input
            name = Console.ReadLine();                  //Store user input inside name var
            Console.WriteLine("Hello {0}!", name);       //Says 'Hello' to the name entered by user
            Console.ReadLine();
        }

        private static void PromptStrings()
        {
            //Various declarations of arrays
            string[] names = { "Marie", "Nate", "Sandra", "James" };                //Declared as a Standard Array
            var himym = new[] { "Ted", "Marshall", "Lilly", "Barney", "Robin" };    //Declared as a Variable
            object[] dynamicArray = { "Marley", 45, true };                         //Declared as an Object Array

            Console.WriteLine("My Family: ");
            for (int i = 0; i < names.Length; i++)
            {
                Console.WriteLine("Index {0} --> {1}", i, names[i]);
                Console.ReadLine();
            }

            Console.WriteLine("The How I Met Your Mother Cast: ");
            for (int i = 0; i < himym.Length; i++)
            {
                Console.WriteLine("Index {0} --> {1}", i, himym[i]);
                Console.ReadLine();
            }

            Console.WriteLine("Dynamic Array: ");
            for (int i = 0; i < dynamicArray.Length; i++)
            {
                Console.WriteLine("Index {0} --> {1}", i, dynamicArray[i]);
                Console.ReadLine();
            }
        }

        private static void PromptUserInput()
        {
            //Converting Data Types & implicit typing 
            Console.Write("Enter a number: ");
            int num = int.Parse(Console.ReadLine());
            Console.WriteLine("You entered the number: {0}, & it has a data type of {1}", num, num.GetType());
            Console.ReadLine();

            Console.Write("Enter a decimal: ");
            decimal dec = decimal.Parse(Console.ReadLine());
            Console.WriteLine("You entered the decimal number: {0} & it has a data type of {1}", dec, dec.GetType());
            Console.ReadLine();

            //Date & Time
            Console.WriteLine("Date & Time: ");
            DateTime myBirthday = new DateTime(1997, 1, 28);
            Console.WriteLine("Marie Kelling was born on a {0}", myBirthday.DayOfWeek);
        }
    }
}
