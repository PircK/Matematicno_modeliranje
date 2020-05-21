function a = premakni_bezier(b,s)
% PREMAKNI_BEZIER translira Bezierovo krivuljo, podano s kontrolnimi
% tockami b, za vektor s. Izrise tudi zacetno in translirano krivuljo
% ter oba kontrolna poligona. 

a = b + s;

hold on
%plotBezier(b);
%plotBezier(a);
%grid on
hold off
end

