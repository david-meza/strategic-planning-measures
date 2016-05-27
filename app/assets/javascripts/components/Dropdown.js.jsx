var Dropdown = React.createClass({
  getInitialState: function () {
    return { data: [] };
  },

  loadKFAsFromServer: function () {
    var setDataState = function (data) {
      this.setState({data: data});
    }.bind(this);

    var xhrError = function (xhr, status, err) {
      console.error(this.props.url, status, err.toString());
    }.bind(this);

    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
    }).then(setDataState, xhrError);
  },

  componentDidMount: function () {
    this.loadKFAsFromServer();
    EventSystem.subscribe('dropdown.update', function(data) {
      console.log(data);
    });
  },

  handleOptionChange: function(e) {
    var newId = e.target.value;
    if (newId === "0") { return; }
    EventSystem.publish('dropdown.update', newId);
  },

  render: function () {
    var optionNodes = this.state.data.map( function (kfa) {
      return <option value={kfa.id} key={kfa.id} >{kfa.name}</option>;
    });
    return (
      <select className="form-control" name={this.props.callbackTargetName + '[' + this.props.dropdownName + '_id]'} id={this.props.callbackTargetName + '_' + this.props.dropdownName + '_id'} onChange={this.handleOptionChange}>
        <option value={this.props.value}>{this.props.label}</option>
        {optionNodes}
      </select>
    );
  }
});
