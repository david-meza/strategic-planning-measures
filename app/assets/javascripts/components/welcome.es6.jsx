class Welcome extends React.Component {
  render () {
    return (
      <div>
        <div>{this.props.title}</div>
      </div>
    );
  }
}

Welcome.propTypes = {
  title: React.PropTypes.string
};
