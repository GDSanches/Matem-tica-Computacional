function lista05()

  clc;
  m=3;
  n=7;
  x=[0.2;0.5;0.8;1.2;1.7;2;2.3];
  y=[500;700;1000;1200;2200;2650;3750];
  valor=1.4;

  [a]=regressaoPolinomial(m,n,x,y);

  A=a(:,1:end-1);
  B=a(:,end);
  gauss=A\B
  printf("\n");

  [r,r2]=calcular2(x,y,gauss,n)
  grafico(x, y, gauss,valor);

endfunction


function [a]=regressaoPolinomial(m,n,x,y)

  if n<m+1
    printf("Regressao impossivel");
    exit;
  endif

  for i=1:m+1
    for j=1:i
      k=i+j-2;
      soma=0;
      for l=1:n
        soma=soma + x(l)^k;
      endfor
      a(i,j)=soma;
      a(j,i)=soma;
    endfor
    soma=0;
    for l=1:n
      soma=soma+y(l)* x(l)^(i-1);
    endfor
    a(i,m+2) = soma;
  endfor
endfunction


function y=polinomio(valor,gauss)
  y=0;
  for i=numel(gauss):-1:1
    y = y + gauss(i)* valor.^(i-1);
  endfor

endfunction


function [r,r2]=calcular2(x,y,gauss,n)
  sr=0;
  st=0;

  for i=1:numel(x)

  sr=sr + (y(i)-polinomio(x(i),gauss))^2;
  st=st + (y(i)-mean(y))^2;

  endfor

  r2=(st-sr)/st;
  r=sqrt(r2);

endfunction


function grafico(x, y, gauss,valor)

  aux = x(1):0.1:x(end);
  auxy=zeros(size(aux));

  Y=polinomio(valor,gauss);

  for i=1:numel(aux)
    auxy(i) = polinomio(aux(i),gauss);
  endfor

    plot(aux,auxy, 'color', 'black');


    hold on;
    plot(x,y,'o', 'markersize', 5, 'color', 'r', 'markerfacecolor', 'r');
    hold off;
    hold on;
    plot(valor,Y,'o', 'markersize', 5, 'color', 'g', 'markerfacecolor', 'g');
    hold off;

    set(gca, 'fontsize', 12);
    title("Grafico");
    legend ("funcao Plolinominal", "ponto de dados","ponto estimado")
    grid on;
    xlabel("x");
    ylabel("y");

endfunction




