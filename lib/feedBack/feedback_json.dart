class FeedbackJson{

    String feedBack;

    FeedbackJson({
      this.feedBack=''
    });

    Map<String, dynamic> toJson() => {
      'feedBack':feedBack
    };

}