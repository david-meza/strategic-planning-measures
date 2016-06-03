var GanttChart = React.createClass({

  getInitialState: function() {
    return { data: [] };
  },

  loadContentFromServer: function () {
    var setDataState = function (data) {
      this.setState({data: data});
      google.charts.setOnLoadCallback(this.drawChart);
    }.bind(this);

    var xhrError = function (xhr, status, err) {
      console.error(this.props.url, status, err.toString());
    }.bind(this);

    $.ajax({
      url: '/initiative_planning_guides',
      method: 'GET',
      dataType: 'json',
      cache: false,
    }).then(setDataState, xhrError);
  },

  chartOptions: {
    // height: 400,
    gantt: {
      trackHeight: 30
    }
  },

  drawChart: function() {

    var SECONDS_IN_YEAR = 31536000000;
    var year = 2015;
    var year2 = 2017;
    
    var chartRows = this.state.data.map( function(planGuideObj) {
      var percentageOfYear = planGuideObj.year === new Date().getFullYear() ? Math.round((new Date(planGuideObj.year, 11, 31) - new Date()) / 31536000000 * 100) : 0;
      return ['Initiative ID #' + planGuideObj.id, planGuideObj.description, planGuideObj.initiative_stage,
              new Date(planGuideObj.year, 0, 1), new Date(planGuideObj.year, 11, 31), SECONDS_IN_YEAR, percentageOfYear, null];
    });
    console.log(chartRows);

    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Planning Guide ID');
    data.addColumn('string', 'Planning Guide Description');
    data.addColumn('string', 'Planning Guide Stage');
    data.addColumn('date', 'Start Date');
    data.addColumn('date', 'End Date');
    data.addColumn('number', 'Duration');
    data.addColumn('number', 'Percent Complete');
    data.addColumn('string', 'Dependencies');

    data.addRows(chartRows);

    var chart = new google.visualization.Gantt(document.getElementById('gantt-chart'));
    chart.draw(data, this.chartOptions);
  },

  componentDidMount: function() {
    this.loadContentFromServer();
    google.charts.load('upcoming', {'packages':['gantt']});
  },

  render: function() {
    return <div id="gantt-chart"></div>;
  }
});

// [
//   ['1.1', 'Initiative 1.1', 'art',
//    new Date(year, 0, 1), new Date(year, 11, 31), SECONDS_IN_YEAR, 100, null],
//   ['1.2', 'Initiative 1.2', 'art',
//    new Date(year, 0, 1), new Date(year, 11, 31), SECONDS_IN_YEAR, 100, null],
//   ['2.1', 'Initiative 2.1', 'finance',
//    new Date(year, 0, 1), new Date(year, 11, 31), SECONDS_IN_YEAR, 100, null],
//   ['2.2', 'Initiative 2.2', 'finance',
//    new Date(year, 0, 1), new Date(year, 11, 31), SECONDS_IN_YEAR, 100, null],
//   ['2.3', 'Initiative 2.3', 'finance',
//    new Date(year, 0, 1), new Date(year, 11, 31), SECONDS_IN_YEAR, 50, null],
//   ['3.1', 'Summer 2015', 'environment',
//    new Date(year, 0, 1), new Date(year, 11, 31), SECONDS_IN_YEAR, 0, null],
//   ['4.1', 'Autumn 2015', 'growth',
//    new Date(year2, 0, 1), new Date(year2, 11, 31), SECONDS_IN_YEAR, 0, null],
//   ['4.2', 'Winter 2015', 'growth',
//    new Date(year2, 0, 1), new Date(year2, 11, 31), SECONDS_IN_YEAR, 0, null],
//   ['4.3', 'Football Season', 'growth',
//    new Date(year2, 0, 1), new Date(year2, 11, 31), SECONDS_IN_YEAR, 100, null],
//   ['4.4', 'Baseball Season', 'growth',
//    new Date(year2, 0, 1), new Date(year2, 11, 31), SECONDS_IN_YEAR, 14, null],
//   ['4.5', 'Basketball Season', 'growth',
//    new Date(year2, 0, 1), new Date(year2, 11, 31), SECONDS_IN_YEAR, 86, null],
//   ['5.1', 'Hockey Season', 'trees',
//    new Date(year2, 0, 1), new Date(year2, 11, 31), SECONDS_IN_YEAR, 89, null]
// ]
