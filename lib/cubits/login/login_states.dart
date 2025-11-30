abstract class login_states {}

class login_init_state extends login_states {}

class login_loading_state extends login_states {}

class login_success_state extends login_states
{
  final String uId;

  login_success_state(this.uId);
}

class login_error_state extends login_states
{
  final String error;

  login_error_state(this.error);
}

class change_password_visibility_state extends login_states {}