using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CsTutorial
{
    class Rectangle : Shape
    {
        public double Length { get; set; }
        public double Width { get; set; }

        public Rectangle(double length, double width)
        {
            Name = "Rectangle";
            Length = length;
            Width = width; 
        }

        public override double Area()
        {
            return Length * Width;
            //throw new NotImplementedException();    //Auto-generated when implemented potential fixes
        }

        public override void GetInfo()
        {
            base.GetInfo();             //Called method from base class
            Console.WriteLine($"This has a Length of {Length}, and a Width of {Width}");
        }
    }
}
