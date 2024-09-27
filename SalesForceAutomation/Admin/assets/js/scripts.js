; (function ($, undefined) {
            var grdPendingOrders;
            var grdShippedOrders;

            var demo = window.demo = {};

            demo.onGridCreated = function (sender, args) {
                grdPendingOrders = $telerik.findControl(document, "grdPendingOrders");
                grdShippedOrders = sender;
            }
            demo.onRowDropping = function (sender, args) {
                if (sender.get_id() == grdPendingOrders.get_id()) {
                    var node = args.get_destinationHtmlElement();
                    if (!isChildOf(grdShippedOrders.get_id(), node) && !isChildOf(grdPendingOrders.get_id(), node)) {
                        args.set_cancel(true);
                    }
                }
                else {
                    var node = args.get_destinationHtmlElement();
                    if (!isChildOf('trashCan', node)) {
                        args.set_cancel(true);
                    }
                    else {
                        if (confirm("Are you sure you want to delete this order?"))
                            args.set_destinationHtmlElement($get('trashCan'));
                        else
                            args.set_cancel(true);
                    }
                }
            };

            function isChildOf(parentId, element) {
                while (element) {
                    if (element.id && element.id.indexOf(parentId) > -1) {
                        return true;
                    }
                    element = element.parentNode;
                }
                return false;
            };
        })($telerik.$);