function bisseccao ()
clc;
xr=0;
xrold=nan;
xl=0;
xu=1;
tolerancia=1e-5;
maxinter=30;

for cont=1:maxinter

  %bisseccao:
  xr=(xl+xu)/2;
  %falsa posição:
  #xr = xu - (funcao(xu) * (xl - xu)) / (funcao(xl) - funcao(xu));

  test= funcao(xl)*funcao(xr);

  if test<0
    xu=xr;
  elseif test>0
    xl=xr;
  else
    break;
   endif

  if abs(xr-xrold) <= tolerancia
    break;
  endif

  xrold=xr;
endfor

  fprintf("A raiz da funcao e: %5f", xr);
  fprintf("A quantidade de interacoes: %5f", cont);


endfunction


function y=funcao(x)

  y=x^3+2*x^2-2;

endfunction
