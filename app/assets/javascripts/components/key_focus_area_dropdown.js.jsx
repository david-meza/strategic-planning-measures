var KeyFocusAreaDropdown = React.createClass({
  getInitialState: function () {
    return { data: [] };
  },

  loadKFAsFromServer: function () {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function (data) {
        this.setState({data: data});
        console.log(this.state);
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  componentDidMount: function () {
    this.loadKFAsFromServer();  
  },

  render: function () {
    var optionNodes = this.state.data.map( function (kfa) {
      return <option value={kfa.id} key={kfa.id} >{kfa.name}</option>;
    });
    return (
      <select className="form-control" name="objective[key_focus_area_id]" id="objective_key_focus_area_id">
        <option value={this.props.value}>{this.props.label}</option>
        {optionNodes}
      </select>
    );
  }
});

