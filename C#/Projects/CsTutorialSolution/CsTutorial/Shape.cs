using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CsTutorial
{
    abstract class Shape       //Very vague - doesn't make sense to instantiate a Shape - no such thing - not enough detail
    {
        public string Name { get; set; }

        public virtual void GetInfo()
        {
            Console.WriteLine($"This is a {Name}"); 
        }

        public abstract double Area();              //Declared as Abstract - to be defined in Shape's derived classes
    }
}
