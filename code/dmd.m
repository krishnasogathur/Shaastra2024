clc;clear;close;clc;

xi = linspace(-5,5,400);
t = linspace(0,2*pi,200);

dt = t(2) - t(1);

[Xgrid,T] = meshgrid(xi,t);
%Xgrid: rows are copies; T: columns are copies. used for parallelization
%essentially

%create two spatio-temporal patterns
f1 = sech(Xgrid-3); w1 = 2.3;
f2 = sech(Xgrid).*tanh(Xgrid); w2 = 2.8;
f3 = tanh(Xgrid); w3 = 1.6;

f = 10*f1.*exp(1i*w1*T)+50*f2.*exp(1i*w2*T) + 25*f3.*exp(1i*w3*T);
%parallelly evaluate all Xis with all ts and store as f1,f2
[u,s,v] = svd(f.');
% we now have created a signal x = sum(b_i*psi_i*exp(i*wi*t)); a superposed
% signal. we now try to use DMD to seperate out best 2 modes.
%figure(1)
%subplot(2,2,1),surfl(Xgrid,T,real(f1)); shading interp; colormap gray;
%subplot(2,2,2),surfl(Xgrid,T,real(f2)); shading interp; colormap gray;
%subplot(2,2,3),surfl(Xgrid,T,real(f)); shading interp; colormap gray;
%figure(2)
%plot(diag(s)/sum(diag(s)),'ro')


figure(2)
subplot(2,1,1),plot(real(u(:,1:3)),"Linewidth",[1])
title("Modal Decomposition through SVD")
% subplot(2,1,2),plot(real(v(:,1:3))) -> time variation


% DMD code


X = f.'; %rows space, time columns

% DMD: breaks up into two pieces
X_init = X(:,1:end-1);
X_final = X(:,2:end);

r = 3;
[U,S,V] = svd(X_init,'econ');
Ur = U(:,1:r);
Sr = S(1:r,1:r);
Vr = V(:,1:r);

A_tilde = Ur'*X_final*Vr/Sr; %reduced form of matrix A

%find eigen decomposition in the reduced space
[W,D] = eig(A_tilde); 

%project the eigenvectors back to the original subspace
Phi =X_final*Vr/Sr*W;   

lambda = diag(D);
omega = log(lambda)/dt/1i;

figure(3); 
subplot(2,1,1),hold on, plot(real(Phi),"Linewidth",[2]) , title("Modal Decomposition via DMD")
subplot(2,1,2),hold on, plot(xi,f1(1,:)),plot(xi,f2(1,:)),plot(xi,f3(1,:)) 
fprintf("The eigenvalues are %.2f, %.2f, %.2f",[omega(1),omega(2),omega(3)])
%gives out the exact modes we provided at the input


