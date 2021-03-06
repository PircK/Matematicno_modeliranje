function X = ver_uv(W0,zac,L,M)
% VER_UV resi problem veriznice iz sistema za u in v.
% Rezultat X je 2x(n+2) tabela koordinat vozlisc, kjer
% prva vrstica doloca abscise, druga ordinate iskanih tock.
%
% Vhodni parametri:
% W0 = [u0;v0] zaceten priblizek pri resevanju sistema
% nelinearnih enacb.
% zac = [x_0 x_n+1;y_0 y_n+1], kjer sta (x_0,y_0) in
% (x_n+1, y_n+1) obesisci.
% L je vrstica, ki doloca dolzine palic.
% M je vrstica, ki doloca mase palic.

n = length(L);

mi = [];
for i=1:n-1
    m = (M(i) + M(i+1)) / 2; %(23)
    mi = [mi m];
end

vsote_mi = [0];
for i=2:n
    vsota = sum(mi(1:i-1)); %(33)
    vsote_mi = [vsote_mi vsota];
end

F = @(W) sistem_uv(W,zac,L,vsote_mi);
Z = fsolve(F,W0);

% z newtonovo metodo
%JF = @(W) jacobian_uv(W,L,vsote_mi);
%Z = newton(sistem,JF,W0,1e-14);

u = Z(1);
v = Z(2);

x = [zac(1,1)];
y = [zac(2,1)];
ksi = 0;
eta = 0;
n = length(L);
for i=1:n
   k = L(i) / sqrt(1 + (v - u * vsote_mi(i))^2); % pod (33)
   ksi = ksi + k;
   eta = eta + k * (v - u * vsote_mi(i));

   x_i = zac(1,1) + ksi; % nad (20)
   y_i = zac(2,1) + eta;
   x = [x x_i];
   y = [y y_i];
end
X = [x; y];

end

