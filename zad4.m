%pocetni uvjet i interval
y0 = [0,1];
tspan = [0,5];
%rjesavamo dif jednadzbu definiranu u odefun.m
%rjesenje pomocu ode45
[t,y] = ode45(@odefun,tspan,y0);
y = y(:,2);
plot([t,y],'-o');
figure

%rjesenje pomocu bvp4c
%korisitmo inital guess def u u guess.m i pomocu njega def solinit
%pocetni uvjeti definirani su u bcfn.m
xmesh = linspace(0,5);
solinit = bvpinit(xmesh, @guess);
sol = bvp4c(@odefun, @bcfn, solinit);
plot(sol.x, sol.y, '-o');

