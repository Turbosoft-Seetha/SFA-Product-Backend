
CanvasJS.addColorSet("YellowShades",
    [//colorSet Array
        "#FEE648",
        "#FF605A"
    ]);

CanvasJS.addColorSet("OrangeShades",
    [//colorSet Array
        "#83DF6D",
        "#FF8C40"
        
    ]);

CanvasJS.addColorSet("GreenShades",
    [//colorSet Array
        "#83DF6D",
        "#FF8C40"
      
    ]);


CanvasJS.addColorSet("ARShades",
    [//colorSet Array
        "#47d9ff",
        "#ecda42"

    ]);

CanvasJS.addColorSet("threelegend",
    [//colorSet Array
        "#EFCC40",
        "#83DF6D",
   
        "#F56363"
    ]);

CanvasJS.addColorSet("Fourlegend",
    [//colorSet Array
        "#51bcde",
        "#76d466",
        "#ef504d",
        "#e3de5d"
    ]);

CanvasJS.addColorSet("3shades",
    [//colorSet Array
        "#4791FF",
        "#02BC77",
        "#FF2366"
    ]);


function ApplyChart(YAxis, XAxis, ChartID, Title, SubTitle, ChartType, shades) {
    //alert(ChartID)
    
    const YAxisArray = YAxis.split('-');
    const XAxisArray = XAxis.split('-');

    var jsonArr = [];
    for (var i = 0; i < YAxisArray.length; i++) {
        jsonArr.push({
            y: YAxisArray[i],
            legendText: XAxisArray[i]
        });
    }

    var chart = new CanvasJS.Chart(ChartID, {
        animationEnabled: true,
        zoomEnabled: true,
        zoomType: "y",
        toolbar: {
            itemBackgroundColor: "#fff",
            itemBackgroundColorOnHover: "#eccaa0",
            buttonBorderColor: "#eccaa0",
            buttonBorderThickness: 2,
            fontColor: "#d6d6d6",
            fontColorOnHover: "#d3d3d3"
        },

        colorSet: shades,
        title: {
            text: Title,
            fontFamily: "Montserrat",
            horizontalAlign: "left",
            fontSize: 15,
            fontWeight: "normal",
            padding: {
                top: 10
            }
        },
        subtitles: [
            {
                padding: {
                    top: -25
                },
                fontSize: 20,
                text: SubTitle,
                fontWeight: "bold",
                fontFamily: "Montserrat",
                horizontalAlign: "right",
                verticalAlign: "top"
            }],
        legend: {
            verticalAlign: "bottom",
            horizontalAlign: "center"
        },

        axisY: {
            labelPlacement: "inside", //Change it to "outside"
            tickPlacement: "inside",
            gridColor: "#ddd",
            valueFormatString: "####"
        },

        data: [{

            cursor: "pointer",
            explodeOnClick: true,
            innerRadius: "65%",
            radius: "80%",
            type: ChartType,
            startAngle: 90,
            indexLabel: "{y}",
            toolTipContent: "{y}",
            showInLegend: true,
            dataPoints: jsonArr
        }]
    });
    chart.render();
}


function ApplyColumnChart(YAxisArray1, XAxisArray1, YAxisArray2 , ChartID , Title) {

    const YAxisArray_1 = YAxisArray1.split('-');
    const YAxisArray_2 = YAxisArray2.split('-');
    const XAxisArray_1 = XAxisArray1.split('-');


    var jsonArr1 = [];
    for (var i = 0; i < YAxisArray_1.length; i++) {
        jsonArr1.push({
            y: parseFloat(YAxisArray_1[i]),
            label: XAxisArray_1[i]
        });
    }

    var jsonArr2 = [];
    for (var i = 0; i < YAxisArray_2.length; i++) {
        jsonArr2.push({
            y: parseFloat(YAxisArray_2[i]) ,
            label: XAxisArray_1[i]
        });
      
    }


    var chart = new CanvasJS.Chart(ChartID,
        {
            zoomEnabled: true,
            zoomType: "y",
            title: {
                text: Title,
                fontFamily: "Montserrat",
                horizontalAlign: "left",
                fontSize: 15,
                fontWeight: "normal",
                padding: {
                    top: 10,
                    bottom:15
                }
            },
            data: [
                {
                    type: "column",
                    showInLegend: true,
                    legendText: "Achieved",
                    color: "#83DF6D",
                    dataPoints: jsonArr1
                },
                {
                    type: "column",
                    showInLegend: true,
                    legendText: "Target",
                    color: "#FF605A",
                    dataPoints: jsonArr2
                }
            ]
        });
    chart.render();
}


function ApplyRightLegend(YAxis, XAxis, ChartID, Title, SubTitle, ChartType, shades) {
    //alert(ChartID)

    CanvasJS.addColorSet("GreenShades",
        [//colorSet Array
            "#FF8C40",
            "#83DF6D"
        ]);

    const YAxisArray = YAxis.split('-');
    const XAxisArray = XAxis.split('-');

    var jsonArr = [];
    for (var i = 0; i < YAxisArray.length; i++) {
        jsonArr.push({
            y: YAxisArray[i],
            legendText: XAxisArray[i] 
        });
    }

    var chart = new CanvasJS.Chart(ChartID, {
        animationEnabled: true,
        zoomEnabled: true,
        zoomType: "y",
        toolbar: {
            itemBackgroundColor: "#fff",
            itemBackgroundColorOnHover: "#eccaa0",
            buttonBorderColor: "#eccaa0",
            buttonBorderThickness: 2,
            fontColor: "#d6d6d6",
            fontColorOnHover: "#d3d3d3"
        },

        colorSet: shades,
        title: {
            text: Title,
            fontFamily: "Montserrat",
            horizontalAlign: "left",
            fontSize: 15,
            fontWeight: "normal",
            padding: {
                top: 10
            }
        },

        legend: {
            horizontalAlign: "right", // "center" , "right"
            verticalAlign: "center",  // "top" , "bottom"
            fontSize: 20,
            padding: {
                top: 50
            },
            maxHeight: 50
        },

        subtitles: [
            {
                padding: {
                    top: -25
                },
                fontSize: 20,
                text: SubTitle,
                fontWeight: "bold",
                fontFamily: "Montserrat",
                horizontalAlign: "right",
                verticalAlign: "top"
            }],

        axisY: {
            labelPlacement: "inside", //Change it to "outside"
            tickPlacement: "inside",
            gridColor: "#ddd",
            valueFormatString: "####"
        },

        data: [{
            cursor: "pointer",
            explodeOnClick: true,
            innerRadius: "65%",
            radius: "80%",
            type: ChartType,
            startAngle: 90,
            indexLabel: "{y}",
            toolTipContent: "{y}",
            showInLegend: true,
            dataPoints: jsonArr

        }]
    });
    chart.render();
}

function ApplySalesChart(YAxisArray1, XAxisArray1, ChartID, Title, SubTitle, shades) {

    const YAxisArray_1 = YAxisArray1.split('-');
    const XAxisArray_1 = XAxisArray1.split('-');

    var jsonArr1 = [];
    for (var i = 0; i < YAxisArray_1.length; i++) {
        jsonArr1.push({
            y: parseFloat(YAxisArray_1[i]),
            legendText: XAxisArray_1[i] ,
            label: XAxisArray_1[i] + ' (' + YAxisArray_1[i] + ')'
        });
    }

    var chart = new CanvasJS.Chart(ChartID,
        {
            zoomEnabled: true,
            zoomType: "y",
            colorSet: shades,
            title: {
                text: Title,
                fontFamily: "Montserrat",
                horizontalAlign: "left",
                fontSize: 15,
                fontWeight: "normal",
                padding: {
                    top: 10,
                    bottom: 15
                }
            },
            legend: {
                verticalAlign: "bottom",
                horizontalAlign: "center"
            },
            subtitles: [
                {
                    padding: {
                        top: -25
                    },
                    fontSize: 20,
                    text: SubTitle,
                    fontWeight: "bold",
                    fontFamily: "Montserrat",
                    horizontalAlign: "right",
                    verticalAlign: "top"
                }],
            data: [
                {
                    type: "column",
                    dataPoints: jsonArr1
                }
            ]
        });
    chart.render();
}


