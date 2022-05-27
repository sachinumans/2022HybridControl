function [v] = FEuler(t_end, u,dt)
variables
%alpha = 10;
a(0)=0;
v(0)=0;
for t=1:t_end/dt
     switch v(t)
          case v(t)<v12&v(t)<alpha
            g(t)=1;
            disp('X1')
          case v(t)<v12&v(t)>alpha
            g(t)=1;
            disp('X2')
          case v(t)>v12&v(t)<v23&v(t)<alpha
            g(t)=2;
            disp('X3')
          case v(t)>v12&v(t)<v23&v(t)>alpha
            g(t)=2;
            disp('X4')
          case v(t)>v23&v(t)<alpha
            g(t)=3;
            disp('X5')
          case v(t)>v23&v(t)>alpha
            g(t)=3;
            disp('X6')
          otherwise
            
        end
    v(t+1)=v(t)+dt*a(t);
    a(t+1)=1/m*((b/(1+gamma*g(t)))-(c*v(t)^2));

    if v(t+1)<10^-3
        v(t+1)=0;
    end
end
