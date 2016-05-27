var Dropdown = React.createClass({
  getInitialState: function () {
    return { data: [] };
  },

  loadContentFromServer: function (options) {
    $('#' + this.selector).removeAttr('disabled');

    var setDataState = function (data) {
      this.setState({data: data});
    }.bind(this);

    var xhrError = function (xhr, status, err) {
      console.error(this.props.url, status, err.toString());
    }.bind(this);

    $.ajax({
      url: this.props.url,
      method: 'GET',
      data: options,
      dataType: 'json',
      cache: false,
    }).then(setDataState, xhrError);
  },

  componentDidMount: function () {
    if (this.props.publisher) {
      EventSystem.subscribe(this.props.publisher + '.update', function(data) {
        this.loadContentFromServer(data);
      }.bind(this));
    } else {
      this.loadContentFromServer();
    }
  },

  handleOptionChange: function(e) {
    var newId = e.target.value;
    if (newId === '') { return; }
    var options = {};
    options[this.props.dropdownName + '_id'] = newId;
    EventSystem.publish(this.props.dropdownName + '.update', options);
  },

  render: function () {
    var optionNodes = this.state.data.map( function (kfa) {
      return <option value={kfa.id} key={kfa.id} >{kfa.name}</option>;
    });
    this.selector = this.props.formOwnerName + '_' + this.props.dropdownName + '_id';
    return (
      <select className="form-control" name={this.props.formOwnerName + '[' + this.props.dropdownName + '_id]'} id={this.selector} onChange={this.handleOptionChange} disabled required>
        <option value="">{this.props.placeholder}</option>
        {optionNodes}
      </select>
    );
  }
});
