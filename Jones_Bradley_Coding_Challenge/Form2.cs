using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace IGTCodingChallenge
{
    public partial class Form2 : Form
    {
      
        Random r = new Random();
        //My created integer lists to hold the X and Y values of the demand and supply points
        List<int> supplyX = new List<int>();
        List<int> supplyY = new List<int>();
        List<int> demandX = new List<int>();
        List<int> demandY = new List<int>();



        public Form2()
        {
            InitializeComponent();
            //Initially populate the graph 100  demand points and 5 supply points
            for(int i = 0; i<105; i++)
            {
             

                if (i < 5)
                {
                    supplyX.Add(r.Next(-100, 500));
                    supplyY.Add(r.Next(-100, 500));
                   

                }
                else
                {
                    demandX.Add(r.Next(-100, 500));
                    demandY.Add(r.Next(-100, 500));
                    //call the function that creates the lines between demand and supply points
                    DrawLine(i);

                }

               
               

            }





            //bind the array values to the Series within the chart
            chart1.Series["Demand Points"].Points.DataBindXY(demandX, demandY);
            chart1.Series["Supply Points"].Points.DataBindXY(supplyX, supplyY);

            //customize graph properties
            chart1.ChartAreas[0].AxisX.Maximum = 500;
            chart1.ChartAreas[0].AxisX.Minimum = -100;

            chart1.ChartAreas[0].AxisY.Maximum = 500;
            chart1.ChartAreas[0].AxisY.Minimum = -100;

            chart1.ChartAreas[0].AxisX.Interval = 50;
            chart1.ChartAreas[0].AxisY.Interval = 50;

        }

       public void DrawLine(int i)
        {
            //Get X and Y values of the demand point the line must go to
            int demandX = this.demandX[i - 5];
            int demandY = this.demandY[i - 5];

          

            //Create and populate a double list of the X and Y differences squared and added together
            List<double> differences = new List<double>();

            for (int j = 0; j < supplyX.Count(); j++)
            {

                differences.Add(Math.Pow(demandX - supplyX[j], 2) + Math.Pow(demandY - supplyY[j], 2));


            }
            //Find the index of the closest supply point
            int index = 100;
            for (int j = 0; j < differences.Count(); j++)
            {
                if (differences.Min() == differences[j])
                {
                    index = j;
                }
            }

            //Add the start and end point for the line to the proper Chart Series
            chart1.Series["Line" + (index + 1)].Points.AddXY(supplyX[index], supplyY[index]);

            chart1.Series["Line" + (index + 1)].Points.AddXY(demandX, demandY);





        }
        

        //Add Demand Point Function
        public void addDP_Click(object sender, MouseEventArgs e)
        {
            //Randomly generate new X and Y values for demand point
           int holderX = r.Next(-100, 500);
            int holderY = r.Next(-100, 500);
            //Add new values to list
            demandX.Add(holderX);
            demandY.Add(holderY);
            //Bind updated array to the "Demand Points" Series
            chart1.Series["Demand Points"].Points.DataBindXY(demandX, demandY);

            //Same process to draw the lines
            List<double> differences = new List<double>();

            for(int i = 0; i<supplyX.Count(); i++)
            {

                differences.Add(Math.Pow(holderX - supplyX[i], 2) + Math.Pow(holderY - supplyY[i], 2));


            }

            int index = 100;
            for(int i = 0; i < differences.Count(); i++)
            {
                if (differences.Min() == differences[i])
                {
                    index = i;
                }
            }


            chart1.Series["Line" + (index+1)].Points.AddXY(supplyX[index], supplyY[index]);

            chart1.Series["Line" + (index+1)].Points.AddXY(holderX, holderY);


        }

        public void  removeDP_Click(object sender, MouseEventArgs e)
        {
            //Make sure there is at least 1 demand point
            if (demandX.Count() == 1)
            {
                MessageBox.Show("Must have at least 1 Demand Point");

            }
            else
            {


                //Remove the last element from the X and Y value arrays
                demandX.RemoveAt(demandX.Count() - 1);
                demandY.RemoveAt(demandY.Count() - 1);
                //Bind updated arrays to the "Demand Points" Series
                chart1.Series["Demand Points"].Points.DataBindXY(demandX, demandY);

                //Erase the existing lines
                for (int i = 0; i < supplyX.Count(); i++)
                {

                    chart1.Series["Line" + (i + 1)].Points.Clear();

                }
                //Redraw lines
                for (int i = 5; i < chart1.Series["Demand Points"].Points.Count() + 5; i++)
                {
                    DrawLine(i);
                }
            }

        }


        public void addSP_Click(object sender, MouseEventArgs e)
        {
            //Create new X and Y values for new supply point
            int holderX = r.Next(-100, 500);
            int holderY = r.Next(-100, 500);
            //Add new values to list
            supplyX.Add(holderX);
            supplyY.Add(holderY);
            //Create new series for demand points closest to new supply point
            chart1.Series.Add("Line"+(supplyX.Count()));
            //Set new Series legend text and change it's ChartType
            chart1.Series["Line" + (supplyX.Count())].ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Line;
            chart1.Series["Line" + (supplyX.Count())].LegendText = "Demand Points closest to Supply Point " + supplyX.Count();

            //Clear old lines
            for (int i = 0; i < supplyX.Count(); i++)
            {

                chart1.Series["Line" + (i + 1)].Points.Clear();

            }
            //Draw new lines
            for (int i = 5; i < chart1.Series["Demand Points"].Points.Count() + 5; i++)
            {
                DrawLine(i);
            }


        }

        //Remove supply point button
        public void removeSP_Click(object sender, MouseEventArgs e)
        {
            //Make sure there is at least 1 demant point
            if (supplyX.Count() == 1)
            {
                MessageBox.Show("Must have at least 1 Supply Point");
            }
            else
            {


                //Remove the last X and Y values from the supply point lists
                supplyX.RemoveAt(supplyX.Count() - 1);
                supplyY.RemoveAt(supplyY.Count() - 1);
                //Remove the entire series of lines that connect to the deleted supply point
                chart1.Series.Remove(chart1.Series["Line" + (supplyX.Count() + 1)]);
                //Bind updated X and Y values to the "Supply Point" Series
                chart1.Series["Supply Points"].Points.DataBindXY(supplyX, supplyY);

                //Clear old lines
                for (int i = 0; i < supplyX.Count(); i++)
                {

                    chart1.Series["Line" + (i + 1)].Points.Clear();

                }
                //Draw  new lines
                for (int i = 5; i < chart1.Series["Demand Points"].Points.Count() + 5; i++)
                {
                    DrawLine(i);
                }

            }
        }

        //Close window button method
        public void closeWindow_Click(object  sender, MouseEventArgs e)
        {
            MessageBox.Show("Thank you for your time!", "Thanks");
            this.Close();
        }


    }
}
