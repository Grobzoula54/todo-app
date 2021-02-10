class Task {

  String _name;
  String _content;
  bool _completed = false;

  Task(this._name);

  getName() => this._name;
  setName(name) => this._name = name;

  getContent() => this._content;
  setContent(content) => this._content = content;

  isCompleted() => this._completed;
  setCompleted(completed) => this._completed = completed;

}