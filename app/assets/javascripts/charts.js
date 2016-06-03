(function(google) {

  $(document).on('page:change', function() {

    if ( $('.initiative_planning_guides.index').length === 0 ) { return; }

    google.charts.load('upcoming', {'packages':['gantt']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var SECONDS_IN_YEAR = 31536000000;
      var year = 2016;
      var year2 = 2017;

      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Planning Guide ID');
      data.addColumn('string', 'Planning Guide Name');
      data.addColumn('string', 'Key Focus Area');
      data.addColumn('date', 'Start Date');
      data.addColumn('date', 'End Date');
      data.addColumn('number', 'Duration');
      data.addColumn('number', 'Percent Complete');
      data.addColumn('string', 'Dependencies');

      data.addRows([
        ['1.1', 'Initiative 1.1', 'art',
         new Date(year, 0, 1), new Date(year, 11, 31), SECONDS_IN_YEAR, 100, null],
        ['1.2', 'Initiative 1.2', 'art',
         new Date(year, 0, 1), new Date(year, 11, 31), SECONDS_IN_YEAR, 100, null],
        ['2.1', 'Initiative 2.1', 'finance',
         new Date(year, 0, 1), new Date(year, 11, 31), SECONDS_IN_YEAR, 100, null],
        ['2.2', 'Initiative 2.2', 'finance',
         new Date(year, 0, 1), new Date(year, 11, 31), SECONDS_IN_YEAR, 100, null],
        ['2.3', 'Initiative 2.3', 'finance',
         new Date(year, 0, 1), new Date(year, 11, 31), SECONDS_IN_YEAR, 50, null],
        ['3.1', 'Summer 2015', 'environment',
         new Date(year, 0, 1), new Date(year, 11, 31), SECONDS_IN_YEAR, 0, null],
        ['4.1', 'Autumn 2015', 'growth',
         new Date(year2, 0, 1), new Date(year2, 11, 31), SECONDS_IN_YEAR, 0, null],
        ['4.2', 'Winter 2015', 'growth',
         new Date(year2, 0, 1), new Date(year2, 11, 31), SECONDS_IN_YEAR, 0, null],
        ['4.3', 'Football Season', 'growth',
         new Date(year2, 0, 1), new Date(year2, 11, 31), SECONDS_IN_YEAR, 100, null],
        ['4.4', 'Baseball Season', 'growth',
         new Date(year2, 0, 1), new Date(year2, 11, 31), SECONDS_IN_YEAR, 14, null],
        ['4.5', 'Basketball Season', 'growth',
         new Date(year2, 0, 1), new Date(year2, 11, 31), SECONDS_IN_YEAR, 86, null],
        ['5.1', 'Hockey Season', 'trees',
         new Date(year2, 0, 1), new Date(year2, 11, 31), SECONDS_IN_YEAR, 89, null]
      ]);

      var options = {
        // height: 400,
        // width: 800,
        gantt: {
          trackHeight: 30
        },
        background: {
          // fill: '#3F51B5'
        }
      };

      var chart = new google.visualization.Gantt(document.getElementById('gantt-chart'));

      chart.draw(data, options);
    }
    

  });

})(google);
