using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class SettlementReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RadWizard1.NavigationBarPosition = (RadWizardNavigationBarPosition)Enum.Parse(typeof(RadWizardNavigationBarPosition), "Left");
            RadWizard1.ProgressBarPosition = (RadWizardProgressBarPosition)Enum.Parse(typeof(RadWizardProgressBarPosition), "Right");
        }

    }
}