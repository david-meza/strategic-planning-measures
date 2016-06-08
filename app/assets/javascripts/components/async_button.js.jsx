var AsyncButton = React.createClass({

  handleClick: function(e) {
    e.preventDefault();
      
    var $target = $(e.target).addClass('disabled');

    setTimeout(function() {
      $target.removeClass('disabled');
    }, 1000); // We must wait at least 1 second so next fields_for addition has a different timestamp

    $.ajax({
      url: this.props.url,
      method: 'GET',
      data: {
        selector: this.props.selector
      },
      dataType: 'script',
      // success: function(response) {
      //   $target.removeClass('disabled');
      // },
      error: function(response, status) {
        console.log(response,status);
      }
    });
  },

  render: function() {
    return (
      <legend className="sublegend layout-row">
        <span>{this.props.legend}</span>
        <span className="flex"></span>
        <a className={"btn btn-success btn-icon text-center " + this.props.buttonClasses} aria-label={this.props.tooltipTitle} title={this.props.tooltipTitle} data-toggle="tooltip" data-placement="top" onClick={this.handleClick}>
          <i className={"fa fa-fw no-events " + this.props.iconClass}></i>
        </a>
      </legend>
    );
  }
});