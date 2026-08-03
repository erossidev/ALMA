class AIDashboardData {

  final int providers;

  final int models;

  final String defaultProvider;

  final int requestsToday;

  final int totalTokens;

  final int averageResponseTime;

  final String mainProvider;

  final String mainModel;


  final List<int> dailyRequests;

  final List<int> dailyTokens;



  const AIDashboardData({

    required this.providers,

    required this.models,

    required this.defaultProvider,

    required this.requestsToday,

    required this.totalTokens,

    required this.averageResponseTime,

    required this.mainProvider,

    required this.mainModel,


    required this.dailyRequests,

    required this.dailyTokens,

  });

}