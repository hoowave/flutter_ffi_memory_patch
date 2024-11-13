class ProcessModel {
  ProcessModel({
    required this.pid,
    required this.name,
  });

  final int pid;
  final String name;

  factory ProcessModel.fromJson(Map<String, dynamic> json) {
    return ProcessModel(
      pid: json['pid'] as int,
      name: json['name'] as String,
    );
  }

  static List<ProcessModel> loadDummyProcesses() {
    return [
      ProcessModel(pid: 101, name: "ProcessA"),
      ProcessModel(pid: 102, name: "ProcessB"),
      ProcessModel(pid: 103, name: "ProcessC"),
      ProcessModel(pid: 104, name: "ProcessD"),
      ProcessModel(pid: 105, name: "ProcessE"),
      ProcessModel(pid: 106, name: "ProcessF"),
      ProcessModel(pid: 107, name: "ProcessG"),
      ProcessModel(pid: 108, name: "ProcessH"),
      ProcessModel(pid: 109, name: "ProcessI"),
      ProcessModel(pid: 110, name: "ProcessJ"),
    ];
  }
}
