using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CsTutorial
{
    class Circle : Shape
    {
        public double Radius { get; set; } 

        public Circle(double radius)
        {
            Name = "Circle";
            Radius = radius; 
        }

        public override double Area()               
        {
            return Math.PI * (Math.Pow(Radius, 2.0)); 
            //throw new NotImplementedException();    //Auto-generated when implemented potential fixes 
        }

        public override void GetInfo()
        {
            base.GetInfo();             //Called method from base class
            Console.WriteLine($"This has a Radius of {Radius}"); 
        }

    }
}
