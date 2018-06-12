using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Windows.Controls;
using System.Windows.Data;

namespace BISEC.Service
{
    public class SumGroupConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            GroupItem groupItem = value as GroupItem;
            CollectionViewGroup collectionViewGroup = groupItem.Content as CollectionViewGroup;
            double sum = 0;

            foreach (var item in collectionViewGroup.Items)
            {
                DataRowView eaRow = item as DataRowView;
                double hr = 0;
                double.TryParse(eaRow["HRS"].ToString(), out hr);
                sum += hr;
            }
            
            return string.Format("Total: {0}", Math.Round(sum,2));
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
