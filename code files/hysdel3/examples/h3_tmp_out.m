h3_optimize_model = [];
 global H3_ALREADY_DISPLAYED,  global H3_AND_LHS_VAR,  global H3_AVOID_BINARY_IMPLICATION,  global H3_REMOVED_BINARIES,  global H3_BOUNDS_STACK,  H3_ALREADY_DISPLAYED.max = {}
  H3_ALREADY_DISPLAYED.min = {}
  H3_BOUNDS_STACK.min = {}
  H3_BOUNDS_STACK.max = {}
  H3_REMOVED_BINARIES = []
  H3_AND_LHS_VAR = []
  H3_SOURCE_LINE = ''
  yalmip('clear')
  h3_define_symbol('reset')
  h3_register_binary('reset')
  lasterr('')
  h3_names.InputName = {}
  h3_names.InputKind = {}
  h3_names.InputLength = {}
  h3_names.StateName = {}
  h3_names.StateKind = {}
  h3_names.StateLength = {}
  h3_names.OutputName = {}
  h3_names.OutputKind = {}
  h3_names.OutputLength = {}
  h3_names.AuxName = {}
  h3_names.AuxKind = {}
  h3_names.AuxLength = {}
  h3_names.ParameterName = {}
  h3_names.ParameterKind = {}
  h3_names.ParameterLength = {}
  h3_yalmip_F = set([])
  h3_yalmip_x_vars = []
  h3_yalmip_xplus_vars = []
  h3_yalmip_u_vars = []
  h3_yalmip_y_vars = []
  h3_yalmip_aux_vars = []
  h3_yalmip_parameters = []
  ,  ,  H3_SOURCE_LINE = 'REAL mass =  1020'
  mass = eval(' 1020')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL beta_friction =  25'
  beta_friction = eval(' 25')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL Rgear1 =  3.7271'
  Rgear1 = eval(' 3.7271')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL Rgear2 =  2.048'
  Rgear2 = eval(' 2.048')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL Rgear3 =  1.321'
  Rgear3 = eval(' 1.321')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL Rgear4 =  0.971'
  Rgear4 = eval(' 0.971')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL Rgear5 =  0.756'
  Rgear5 = eval(' 0.756')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL RgearR = - 3.545'
  RgearR = eval('- 3.545')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL wheel_rim =  14'
  wheel_rim = eval(' 14')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL tire_width =  175'
  tire_width = eval(' 175')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL tire_height_perc =  65'
  tire_height_perc = eval(' 65')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL R_final =  3.294'
  R_final = eval(' 3.294')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL loss =  0.925'
  loss = eval(' 0.925')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL pi =  3.1415'
  pi = eval(' 3.1415')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL inch =  2.54'
  inch = eval(' 2.54')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL wheel_radius = ( wheel_rim / 2* inch+( tire_width / 10)*( tire_height_perc / 100)) / 100'
  wheel_radius = eval('( wheel_rim / 2* inch+( tire_width / 10)*( tire_height_perc / 100)) / 100')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL speed_factor =  loss / R_final* wheel_radius'
  speed_factor = eval(' loss / R_final* wheel_radius')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL max_brake =  8.53'
  max_brake = eval(' 8.53')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL max_brake_force =  mass* max_brake'
  max_brake_force = eval(' mass* max_brake')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL wemin = - 100* 2* pi / 60'
  wemin = eval('- 100* 2* pi / 60')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL wemax =  6000* 2* pi / 60'
  wemax = eval(' 6000* 2* pi / 60')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL Ts =  0.5'
  Ts = eval(' 0.5')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL aPWL1 =  0'
  aPWL1 = eval(' 0')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL aPWL2 =  58.107'
  aPWL2 = eval(' 58.107')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL aPWL3 =  151.7613'
  aPWL3 = eval(' 151.7613')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL aPWL4 =  192.8526'
  aPWL4 = eval(' 192.8526')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL aPWL5 =  259.9484'
  aPWL5 = eval(' 259.9484')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL bPWL1 =  1.3281'
  bPWL1 = eval(' 1.3281')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL bPWL2 =  0.6344'
  bPWL2 = eval(' 0.6344')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL bPWL3 =  0.0755'
  bPWL3 = eval(' 0.0755')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL bPWL4 = - 0.088'
  bPWL4 = eval('- 0.088')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL bPWL5 = - 0.2883'
  bPWL5 = eval('- 0.2883')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL wPWL1 =  83.7733'
  wPWL1 = eval(' 83.7733')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL wPWL2 =  167.5467'
  wPWL2 = eval(' 167.5467')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL wPWL3 =  251.32'
  wPWL3 = eval(' 251.32')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL wPWL4 =  335.0933'
  wPWL4 = eval(' 335.0933')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL alpha1 =  10'
  alpha1 = eval(' 10')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL beta1 =  0.3'
  beta1 = eval(' 0.3')
  h3_define_symbol('advance')
  ,  H3_SOURCE_LINE = 'REAL position(1, 1) [- 1000 , 1000] '
  h3_var_bounds = eval('[- 1000 , 1000]')
  position = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'position', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= position(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL position_plus(1, 1) [- 1000 , 1000] '
  h3_var_bounds = eval('[- 1000 , 1000]')
  position_plus = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'position_plus', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= position_plus(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL speed(1, 1) [- 50* 1000 / 3600 , 220* 1000 / 3600] '
  h3_var_bounds = eval('[- 50* 1000 / 3600 , 220* 1000 / 3600]')
  speed = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'speed', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= speed(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL speed_plus(1, 1) [- 50* 1000 / 3600 , 220* 1000 / 3600] '
  h3_var_bounds = eval('[- 50* 1000 / 3600 , 220* 1000 / 3600]')
  speed_plus = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'speed_plus', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= speed_plus(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL torque(1, 1) [- 300 , 300] '
  h3_var_bounds = eval('[- 300 , 300]')
  torque = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'torque', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= torque(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL F_brake(1, 1) [ 0 , 9000] '
  h3_var_bounds = eval('[ 0 , 9000]')
  F_brake = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'F_brake', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= F_brake(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'BOOL gear1(1, 1)'
  gear1 = binvar(1, 1, 'full')
  h3_define_symbol('add', 'gear1', (1)*(1))
  ,  H3_SOURCE_LINE = 'BOOL gear2(1, 1)'
  gear2 = binvar(1, 1, 'full')
  h3_define_symbol('add', 'gear2', (1)*(1))
  ,  H3_SOURCE_LINE = 'BOOL gear3(1, 1)'
  gear3 = binvar(1, 1, 'full')
  h3_define_symbol('add', 'gear3', (1)*(1))
  ,  H3_SOURCE_LINE = 'BOOL gear4(1, 1)'
  gear4 = binvar(1, 1, 'full')
  h3_define_symbol('add', 'gear4', (1)*(1))
  ,  H3_SOURCE_LINE = 'BOOL gear5(1, 1)'
  gear5 = binvar(1, 1, 'full')
  h3_define_symbol('add', 'gear5', (1)*(1))
  ,  H3_SOURCE_LINE = 'BOOL gearR(1, 1)'
  gearR = binvar(1, 1, 'full')
  h3_define_symbol('add', 'gearR', (1)*(1))
  ,  H3_SOURCE_LINE = 'REAL Fe1(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  Fe1 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'Fe1', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= Fe1(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL Fe2(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  Fe2 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'Fe2', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= Fe2(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL Fe3(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  Fe3 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'Fe3', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= Fe3(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL Fe4(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  Fe4 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'Fe4', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= Fe4(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL Fe5(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  Fe5 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'Fe5', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= Fe5(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL FeR(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  FeR = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'FeR', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= FeR(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL w1(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  w1 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'w1', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= w1(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL w2(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  w2 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'w2', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= w2(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL w3(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  w3 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'w3', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= w3(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL w4(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  w4 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'w4', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= w4(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL w5(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  w5 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'w5', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= w5(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL wR(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  wR = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'wR', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= wR(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'BOOL dPWL1(1, 1)'
  dPWL1 = binvar(1, 1, 'full')
  h3_define_symbol('add', 'dPWL1', (1)*(1))
  ,  H3_SOURCE_LINE = 'BOOL dPWL2(1, 1)'
  dPWL2 = binvar(1, 1, 'full')
  h3_define_symbol('add', 'dPWL2', (1)*(1))
  ,  H3_SOURCE_LINE = 'BOOL dPWL3(1, 1)'
  dPWL3 = binvar(1, 1, 'full')
  h3_define_symbol('add', 'dPWL3', (1)*(1))
  ,  H3_SOURCE_LINE = 'BOOL dPWL4(1, 1)'
  dPWL4 = binvar(1, 1, 'full')
  h3_define_symbol('add', 'dPWL4', (1)*(1))
  ,  H3_SOURCE_LINE = 'REAL DCe1(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  DCe1 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'DCe1', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= DCe1(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL DCe2(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  DCe2 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'DCe2', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= DCe2(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL DCe3(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  DCe3 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'DCe3', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= DCe3(:) <= h3_var_bounds(:,2), 'bounds')
  ,  H3_SOURCE_LINE = 'REAL DCe4(1, 1)'
  h3_var_bounds = eval('[-Inf Inf]')
  DCe4 = sdpvar(1, 1, 'full')
  h3_define_symbol('add', 'DCe4', (1)*(1))
  h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= DCe4(:) <= h3_var_bounds(:,2), 'bounds')
  ,  h3_yalmip_x_vars = [h3_yalmip_x_vars(:)
 position(:)
 speed(:)]
  h3_yalmip_xplus_vars = [h3_yalmip_xplus_vars(:)
 position_plus(:)
 speed_plus(:)]
  h3_yalmip_u_vars = [h3_yalmip_u_vars(:)
 torque(:)
 F_brake(:)
 gear1(:)
 gear2(:)
 gear3(:)
 gear4(:)
 gear5(:)
 gearR(:)]
  h3_yalmip_y_vars = [h3_yalmip_y_vars(:)
 ]
  h3_yalmip_aux_vars = [h3_yalmip_aux_vars(:)
 Fe1(:)
 Fe2(:)
 Fe3(:)
 Fe4(:)
 Fe5(:)
 FeR(:)
 w1(:)
 w2(:)
 w3(:)
 w4(:)
 w5(:)
 wR(:)
 dPWL1(:)
 dPWL2(:)
 dPWL3(:)
 dPWL4(:)
 DCe1(:)
 DCe2(:)
 DCe3(:)
 DCe4(:)]
  h3_yalmip_variables = [h3_yalmip_x_vars
 h3_yalmip_xplus_vars
 h3_yalmip_u_vars
 h3_yalmip_y_vars
 h3_yalmip_aux_vars]
  ,  h3_names.InputName =  cat(2, h3_names.InputName, { 'torque' ,  'F_brake' ,  'gear1' ,  'gear2' ,  'gear3' ,  'gear4' ,  'gear5' ,  'gearR' })
 ,  h3_names.InputKind =  cat(2, h3_names.InputKind, { 'r' ,  'r' ,  'b' ,  'b' ,  'b' ,  'b' ,  'b' ,  'b' })
 ,  h3_names.InputLength =  cat(2, h3_names.InputLength, { eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) })
 ,  h3_names.StateName =  cat(2, h3_names.StateName, { 'position' ,  'speed' })
 ,  h3_names.StateKind =  cat(2, h3_names.StateKind, { 'r' ,  'r' })
 ,  h3_names.StateLength =  cat(2, h3_names.StateLength, { eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) })
 ,  h3_names.AuxName =  cat(2, h3_names.AuxName, { 'Fe1' ,  'Fe2' ,  'Fe3' ,  'Fe4' ,  'Fe5' ,  'FeR' ,  'w1' ,  'w2' ,  'w3' ,  'w4' ,  'w5' ,  'wR' ,  'dPWL1' ,  'dPWL2' ,  'dPWL3' ,  'dPWL4' ,  'DCe1' ,  'DCe2' ,  'DCe3' ,  'DCe4' })
 ,  h3_names.AuxKind =  cat(2, h3_names.AuxKind, { 'r' ,  'r' ,  'r' ,  'r' ,  'r' ,  'r' ,  'r' ,  'r' ,  'r' ,  'r' ,  'r' ,  'r' ,  'b' ,  'b' ,  'b' ,  'b' ,  'r' ,  'r' ,  'r' ,  'r' })
 ,  h3_names.AuxLength =  cat(2, h3_names.AuxLength, { eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) ,  eval( '(1) * (1)' ) })
 ,  H3_SOURCE_LINE = ' dPWL1= wPWL1-( w1+ w2+ w3+ w4+ w5+ wR) <= 0
'
  h3_yalmip_F = h3_yalmip_F + h3_iff( wPWL1-( w1+ w2+ w3+ w4+ w5+ wR) <= 0,  dPWL1)
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' dPWL2= wPWL2-( w1+ w2+ w3+ w4+ w5+ wR) <= 0
'
  h3_yalmip_F = h3_yalmip_F + h3_iff( wPWL2-( w1+ w2+ w3+ w4+ w5+ wR) <= 0,  dPWL2)
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' dPWL3= wPWL3-( w1+ w2+ w3+ w4+ w5+ wR) <= 0
'
  h3_yalmip_F = h3_yalmip_F + h3_iff( wPWL3-( w1+ w2+ w3+ w4+ w5+ wR) <= 0,  dPWL3)
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' dPWL4= wPWL4-( w1+ w2+ w3+ w4+ w5+ wR) <= 0
'
  h3_yalmip_F = h3_yalmip_F + h3_iff( wPWL4-( w1+ w2+ w3+ w4+ w5+ wR) <= 0,  dPWL4)
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' Fe1={ IF gear1 THEN torque / speed_factor* Rgear1}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( Fe1,  gear1,  torque / speed_factor* Rgear1, 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' Fe2={ IF gear2 THEN torque / speed_factor* Rgear2}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( Fe2,  gear2,  torque / speed_factor* Rgear2, 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' Fe3={ IF gear3 THEN torque / speed_factor* Rgear3}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( Fe3,  gear3,  torque / speed_factor* Rgear3, 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' Fe4={ IF gear4 THEN torque / speed_factor* Rgear4}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( Fe4,  gear4,  torque / speed_factor* Rgear4, 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' Fe5={ IF gear5 THEN torque / speed_factor* Rgear5}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( Fe5,  gear5,  torque / speed_factor* Rgear5, 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' FeR={ IF gearR THEN torque / speed_factor* RgearR}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( FeR,  gearR,  torque / speed_factor* RgearR, 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' w1={ IF gear1 THEN speed / speed_factor* Rgear1}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( w1,  gear1,  speed / speed_factor* Rgear1, 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' w2={ IF gear2 THEN speed / speed_factor* Rgear2}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( w2,  gear2,  speed / speed_factor* Rgear2, 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' w3={ IF gear3 THEN speed / speed_factor* Rgear3}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( w3,  gear3,  speed / speed_factor* Rgear3, 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' w4={ IF gear4 THEN speed / speed_factor* Rgear4}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( w4,  gear4,  speed / speed_factor* Rgear4, 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' w5={ IF gear5 THEN speed / speed_factor* Rgear5}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( w5,  gear5,  speed / speed_factor* Rgear5, 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' wR={ IF gearR THEN speed / speed_factor* RgearR}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( wR,  gearR,  speed / speed_factor* RgearR, 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' DCe1={ IF dPWL1 THEN( aPWL2- aPWL1)+( bPWL2- bPWL1)*( w1+ w2+ w3+ w4+ w5+ wR)}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( DCe1,  dPWL1, ( aPWL2- aPWL1)+( bPWL2- bPWL1)*( w1+ w2+ w3+ w4+ w5+ wR), 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' DCe2={ IF dPWL2 THEN( aPWL3- aPWL2)+( bPWL3- bPWL2)*( w1+ w2+ w3+ w4+ w5+ wR)}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( DCe2,  dPWL2, ( aPWL3- aPWL2)+( bPWL3- bPWL2)*( w1+ w2+ w3+ w4+ w5+ wR), 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' DCe3={ IF dPWL3 THEN( aPWL4- aPWL3)+( bPWL4- bPWL3)*( w1+ w2+ w3+ w4+ w5+ wR)}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( DCe3,  dPWL3, ( aPWL4- aPWL3)+( bPWL4- bPWL3)*( w1+ w2+ w3+ w4+ w5+ wR), 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' DCe4={ IF dPWL4 THEN( aPWL5- aPWL4)+( bPWL5- bPWL4)*( w1+ w2+ w3+ w4+ w5+ wR)}
'
  h3_yalmip_F = h3_yalmip_F + h3_ifthenelse( DCe4,  dPWL4, ( aPWL5- aPWL4)+( bPWL5- bPWL4)*( w1+ w2+ w3+ w4+ w5+ wR), 0) 
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' position= position+ Ts* speed
'
  h3_yalmip_F = h3_yalmip_F + set( position_plus == ( position+ Ts* speed), 'update')
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' speed= speed+ Ts / mass*( Fe1+ Fe2+ Fe3+ Fe4+ Fe5+ FeR- F_brake- beta_friction* speed)
'
  h3_yalmip_F = h3_yalmip_F + set( speed_plus == ( speed+ Ts / mass*( Fe1+ Fe2+ Fe3+ Fe4+ Fe5+ FeR- F_brake- beta_friction* speed)), 'update')
  h3_define_symbol('advance')
  H3_SOURCE_LINE = '- w1 <=- wemin
'
  h3_yalmip_F = h3_yalmip_F + set( - w1 <=- wemin, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' w1 <= wemax
'
  h3_yalmip_F = h3_yalmip_F + set(  w1 <= wemax, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = '- w2 <=- wemin
'
  h3_yalmip_F = h3_yalmip_F + set( - w2 <=- wemin, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' w2 <= wemax
'
  h3_yalmip_F = h3_yalmip_F + set(  w2 <= wemax, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = '- w3 <=- wemin
'
  h3_yalmip_F = h3_yalmip_F + set( - w3 <=- wemin, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' w3 <= wemax
'
  h3_yalmip_F = h3_yalmip_F + set(  w3 <= wemax, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = '- w4 <=- wemin
'
  h3_yalmip_F = h3_yalmip_F + set( - w4 <=- wemin, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' w4 <= wemax
'
  h3_yalmip_F = h3_yalmip_F + set(  w4 <= wemax, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = '- w5 <=- wemin
'
  h3_yalmip_F = h3_yalmip_F + set( - w5 <=- wemin, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' w5 <= wemax
'
  h3_yalmip_F = h3_yalmip_F + set(  w5 <= wemax, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = '- wR <=- wemin
'
  h3_yalmip_F = h3_yalmip_F + set( - wR <=- wemin, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' wR <= wemax
'
  h3_yalmip_F = h3_yalmip_F + set(  wR <= wemax, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = '- F_brake <= 0
'
  h3_yalmip_F = h3_yalmip_F + set( - F_brake <= 0, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' F_brake <= max_brake_force
'
  h3_yalmip_F = h3_yalmip_F + set(  F_brake <= max_brake_force, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = '- torque-( alpha1+ beta1*( w1+ w2+ w3+ w4+ w5+ wR)) <= 0
'
  h3_yalmip_F = h3_yalmip_F + set( - torque-( alpha1+ beta1*( w1+ w2+ w3+ w4+ w5+ wR)) <= 0, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' torque-( aPWL1+ bPWL1*( w1+ w2+ w3+ w4+ w5+ wR)+ DCe1+ DCe2+ DCe3+ DCe4)- 1 <= 0
'
  h3_yalmip_F = h3_yalmip_F + set(  torque-( aPWL1+ bPWL1*( w1+ w2+ w3+ w4+ w5+ wR)+ DCe1+ DCe2+ DCe3+ DCe4)- 1 <= 0, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = '-(( REAL gear1)+( REAL gear2)+( REAL gear3)+( REAL gear4)+( REAL gear5)+( REAL gearR)) <=- 0.9999
'
  h3_yalmip_F = h3_yalmip_F + set( -((  gear1)+(  gear2)+(  gear3)+(  gear4)+(  gear5)+(  gearR)) <=- 0.9999, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = '( REAL gear1)+( REAL gear2)+( REAL gear3)+( REAL gear4)+( REAL gear5)+( REAL gearR) <= 1.0001
'
  h3_yalmip_F = h3_yalmip_F + set( (  gear1)+(  gear2)+(  gear3)+(  gear4)+(  gear5)+(  gearR) <= 1.0001, 'must' )
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' dPWL4 -> dPWL3
'
  h3_yalmip_F = h3_yalmip_F + h3_logic_item((( dPWL4) <= ( dPWL3)), 'must')
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' dPWL4 -> dPWL2
'
  h3_yalmip_F = h3_yalmip_F + h3_logic_item((( dPWL4) <= ( dPWL2)), 'must')
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' dPWL4 -> dPWL1
'
  h3_yalmip_F = h3_yalmip_F + h3_logic_item((( dPWL4) <= ( dPWL1)), 'must')
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' dPWL3 -> dPWL2
'
  h3_yalmip_F = h3_yalmip_F + h3_logic_item((( dPWL3) <= ( dPWL2)), 'must')
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' dPWL3 -> dPWL1
'
  h3_yalmip_F = h3_yalmip_F + h3_logic_item((( dPWL3) <= ( dPWL1)), 'must')
  h3_define_symbol('advance')
  H3_SOURCE_LINE = ' dPWL2 -> dPWL1
'
  h3_yalmip_F = h3_yalmip_F + h3_logic_item((( dPWL2) <= ( dPWL1)), 'must')
  h3_define_symbol('advance')
  h3_symtable = {}
  h3_symtable_entry = []
  h3_symtable_entry.name = 'mass'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'beta_friction'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'Rgear1'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'Rgear2'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'Rgear3'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'Rgear4'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'Rgear5'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'RgearR'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'wheel_rim'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'tire_width'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'tire_height_perc'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'R_final'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'loss'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'pi'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'inch'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'wheel_radius'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'speed_factor'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'max_brake'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'max_brake_force'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'wemin'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'wemax'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'Ts'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'aPWL1'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'aPWL2'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'aPWL3'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'aPWL4'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'aPWL5'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'bPWL1'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'bPWL2'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'bPWL3'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'bPWL4'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'bPWL5'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'wPWL1'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'wPWL2'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'wPWL3'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'wPWL4'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'alpha1'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'beta1'
  h3_symtable_entry.orig_type = 'parameter'
  h3_symtable_entry.type = 'parameter'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'position'
  h3_symtable_entry.orig_type = 'state'
  h3_symtable_entry.type = 'state'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'speed'
  h3_symtable_entry.orig_type = 'state'
  h3_symtable_entry.type = 'state'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'torque'
  h3_symtable_entry.orig_type = 'input'
  h3_symtable_entry.type = 'input'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'F_brake'
  h3_symtable_entry.orig_type = 'input'
  h3_symtable_entry.type = 'input'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'gear1'
  h3_symtable_entry.orig_type = 'input'
  h3_symtable_entry.type = 'input'
  h3_symtable_entry.kind = 'bool'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'gear2'
  h3_symtable_entry.orig_type = 'input'
  h3_symtable_entry.type = 'input'
  h3_symtable_entry.kind = 'bool'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'gear3'
  h3_symtable_entry.orig_type = 'input'
  h3_symtable_entry.type = 'input'
  h3_symtable_entry.kind = 'bool'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'gear4'
  h3_symtable_entry.orig_type = 'input'
  h3_symtable_entry.type = 'input'
  h3_symtable_entry.kind = 'bool'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'gear5'
  h3_symtable_entry.orig_type = 'input'
  h3_symtable_entry.type = 'input'
  h3_symtable_entry.kind = 'bool'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'gearR'
  h3_symtable_entry.orig_type = 'input'
  h3_symtable_entry.type = 'input'
  h3_symtable_entry.kind = 'bool'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'Fe1'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'Fe2'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'Fe3'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'Fe4'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'Fe5'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'FeR'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'w1'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'w2'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'w3'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'w4'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'w5'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'wR'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'dPWL1'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'bool'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'dPWL2'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'bool'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'dPWL3'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'bool'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'dPWL4'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'bool'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'DCe1'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'DCe2'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'DCe3'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
  h3_symtable_entry = []
  h3_symtable_entry.name = 'DCe4'
  h3_symtable_entry.orig_type = 'aux'
  h3_symtable_entry.type = 'aux'
  h3_symtable_entry.kind = 'real'
  h3_symtable{end+1} = h3_symtable_entry
 
