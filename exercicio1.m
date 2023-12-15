function exercicio1()
  clc;
  xr = 0;
  xrold = nan;
  xl = 3;
  xu = 4;
  nmaxinter = 20;
  tolerancia = 1e-5;

  interacoesdex = zeros(nmaxinter,1);
  interacoesdefx = zeros(nmaxinter,1);

  for cont =1:nmaxinter

   xr = (xl + xu)/2
   interacoesdex(cont) = xr;

   fxr = funcao(xr);
   interacoesdefx(cont) = fxr;



    test = funcao(xl) * funcao(xr);

    if test < 0
      xu = xr;
     elseif test > 0
      xl = xr;
    else
      break;
    endif

     if abs(xr-xrold) <= tolerancia
       break;
      endif

    xrold = xr;
  endfor

  interacoesdefx=interacoesdefx(1:cont);
  interacoesdex=interacoesdex(1:cont);




  fprintf("A raiz da funcao e: %5f", xr);
  fprintf("A quantidade de interacoes: %5f", cont);

  grafico(cont,interacoesdefx,interacoesdex);
  graficoAnimado(interacoesdex,interacoesdefx,cont);
  #figure(1);
  #plot(interacoesdex, interacoesdefx,'linewidth', 3);
endfunction

function y = funcao(x)
  y = tan(x)*(35/2 * x^3 -44*x^2 + 887*x + 229);
endfunction


function grafico(iter, FXR, XR)
  figure(2);

  % Primeiro gráfico
  subplot(2, 1, 1);
  plot(1:iter, XR, 'linewidth', 2);
  #set(gca);
  ylabel('x', 'fontsize', 15);
  xlabel('Iteracao', 'fontsize', 15);
  grid on;
  title('Grafico de convergencia de x');


  % Segundo gráfico
  subplot(2, 1, 2);
  plot(1:iter, FXR, 'linewidth', 2);
  #set(gca);
  ylabel('f(x)', 'fontsize', 15);
  xlabel('Iteracao', 'fontsize', 15);
  grid on;
  title('Grafico de convergencia de f(x)');

end

function graficoAnimado(XR,FXR,cont)

  figure(3);

  for iter = 1:cont
    plot(XR, FXR, 'linewidth', 2, 'color', 'black');
    hold on;
    plot(XR(iter), FXR(iter), 'o', 'markersize', 10, 'markerfacecolor', 'red');
    hold off;
    #set(gca, 'fontsize', 12);
    grid on;
    xlabel('x', 'fontsize', 20);
    ylabel('fx', 'fontsize', 20);
    legend("linha da função","ponto de covergencia");
    title("Grafico Animado da função y = tan(x)*(35/2 * x^3 -44*x^2 + 887*x + 229)");

    pause(0.3);
  end

end



