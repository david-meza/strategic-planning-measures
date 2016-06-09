var GanttChart = React.createClass({

  getInitialState: function() {
    return { data: [] };
  },

  loadContentFromServer: function () {
    var setDataState = function (data) {
      this.setState({data: data});
      if (google.visualization && google.visualization.DataTable && google.visualization.Gantt) {
        this.drawChart();
      } else {
        google.charts.setOnLoadCallback(this.drawChart);
      }
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
    gantt: {
      trackHeight: 35,
      barHeight: 25
    }
  },

  drawChart: function() {

    var SECONDS_IN_YEAR = 31536000000;

    function withinFiscalYear(year) {
      var fiscalYearStart = new Date(year - 1, 06, 01);
      var today = new Date();
      return today - fiscalYearStart < SECONDS_IN_YEAR && today - fiscalYearStart > 0;
    }

    function calculateProgressUntilEOY(year) {
      return 100 - Math.round((new Date(year, 05, 30) - new Date()) / 31536000000 * 100);
    }

    function calculatePercentageOfYear(year) {
      if ( withinFiscalYear(year) ) {
        return calculateProgressUntilEOY(year);
      } else if ( year > new Date().getFullYear() ) {
        return 0;
      }
      return 100;
    }

    function convertDataToArray(planGuideObj) {
      var y = planGuideObj.year;
      var percentageOfYear = calculatePercentageOfYear(y);
      return ['Initiative ID #' + planGuideObj.id, planGuideObj.description, planGuideObj.initiative_stage,
              new Date(y - 1, 06, 01), new Date(y, 05, 30), SECONDS_IN_YEAR, percentageOfYear, null];
    }

    function guidesWithoutYear(guide) { 
      return typeof guide.year !== 'undefined';
    }

    var chartRows = this.state.data.filter( guidesWithoutYear ).map( convertDataToArray );

    var dataTable = new google.visualization.DataTable();
    
    dataTable.addColumn('string', 'Plan ID');
    dataTable.addColumn('string', 'Plan Description');
    dataTable.addColumn('string', 'Plan Stage');
    dataTable.addColumn('date', 'Start Date');
    dataTable.addColumn('date', 'End Date');
    dataTable.addColumn('number', 'Duration');
    dataTable.addColumn('number', 'Percent Complete');
    dataTable.addColumn('string', 'Dependencies');

    dataTable.addRows(chartRows);

    this.chartOptions.height = dataTable.getNumberOfRows() * 35 + 45;
    var chart = new google.visualization.Gantt(document.getElementById('gantt-chart'));
    chart.draw(dataTable, this.chartOptions);
  },

  componentDidMount: function() {
    google.charts.load('upcoming', {'packages':['gantt']});
    this.loadContentFromServer();
  },

  render: function() {
    return <div id="gantt-chart"></div>;
  }
});
