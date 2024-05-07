%funkcija kreira zadanu matricu za dane parametre k1,k2,k3
%potom se vrsi kompozicija ldl tako da je A = L*D*L'
function [L,D] = zad5(k1,k2,k3)
    A = zeros(2);
    A(1,1) = k1+k2;
    A(1,2) = -k2;
    A(2,1) = -k2;
    A(2,2) = k2+k3;
    [L,D] = ldl(A);
end