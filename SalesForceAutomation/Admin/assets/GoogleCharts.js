function ApplyPieChart(XAxis = null, YAxis = null) {
    
    const XAxisArray = XAxis.split('-');
    const YAxisArray = YAxis.split('-');
    
    // Create the data table.

    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Label');
    data.addColumn('number', 'Value');
    data.addColumn({ type: 'string', role: 'tooltip' });

    for (let i = 0; i < XAxisArray.length; i++) {
        data.addRow(
            [XAxisArray[i], parseInt(YAxisArray[i]), YAxisArray[i]]
        );
    }

    // Set chart options
    var options = {
        'legend': 'bottom',
        'title': 'Total Visits',
        'titleTextStyle': { 'fontSize': 15 },
        'pieHole': 0.7,
        'colors': ['#83DF6D', '#FF8C40'],
        'width': 310,
        'height': 310,
        'pieSliceText': 'value',
        'tooltip': { 'Text': 'value' },
        'vAxis': { 'format': '0' },
        'timeline': { 'groupByRowLabel': true, 'showRowLabels': true, 'rowLabelStyle': { 'fontSize': 50 }, 'barLabelStyle': { 'fontSize': 50 } }
    };

    // Instantiate and draw our chart, passing in some options.
    var chart = new google.visualization.PieChart(document.getElementById('CusTotalVisits'));
    chart.draw(data, options);
    
}