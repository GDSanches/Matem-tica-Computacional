function exercicio3()
clc;
t=[2;
 5;
 0];

s=[2,1,0;
 5,-1,1;
 -1,2,2
 ];
A=[s,t];
A
gaussjordan(A);
A
[A]=zera(A);
[A]=zeracima(A);
A
x=s\t;
x
endfunction

function gaussjordan(A)
  for i=1:size(A,1)-1
    if (A(i,i) < A(i+1,i))
       aux = A(i,:);
       A(i,:) = A(i+1,:);
       A(i+1,:) = aux;
    endif
endfor
endfunction

function [A]=zera(A)
  for i=1:size(A,1)
    A(i,:)=A(i,:)/A(i,i);
    for j=i+1:size(A,1)
      A(j,:)=A(j,:)-A(j,i)*A(i,:);
    endfor
  endfor
endfunction

function [A]=zeracima(A)
  for i=size(A,1):-1:1
    for j=i-1:-1:1
      A(j,:)=A(j,:)- A(j,i)*A(i,:);

    endfor
  endfor
endfunction
