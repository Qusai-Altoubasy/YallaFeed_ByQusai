abstract class register_states {}

class register_init_state extends register_states {}

class register_loading_state extends register_states {}

class register_success_state extends register_states {}

class register_error_state extends register_states
{
  final String error;

  register_error_state(this.error);
}

class register_change_password_visibility_state extends register_states {}
class loading extends register_states {}
class done extends register_states {}