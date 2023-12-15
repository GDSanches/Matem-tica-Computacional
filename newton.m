function newton()
  clc;
  maxinter =1000;
  tolerancia=1e-3;
  x0=[(4.5/5)*pi;
      (4.5/5)*pi];
  resultado = [pi; pi];

  #[x0,cont,todosx,todosfx]=Metodogradient(tolerancia,x0,maxinter);
  [x0,cont,todosx,todosfx]=Metodonewton(tolerancia,x0,maxinter);
  h=heuclidiana(x0,resultado);
  fprintf("distancia heuclidiana:%.6f" ,h);
  fprintf("\nNumero de Iteracoes:%.1f\n" ,cont);
  x0
  grdficodeconvergencia(todosx,todosfx,cont);
  geraGraficoFuncao(todosx, todosfx, cont);


endfunction

function [x0,cont,todosx,todosfx]=Metodogradient(tolerancia,x0,maxinter)

  alfa=0.335;

  todosx=zeros(2,maxinter);
  todosfx=zeros(1,maxinter);

  for cont=1:maxinter
    x1=x0-(alfa*gradient_f(x0));
    todosx(:,cont)=x1;
    todosfx(1,cont)=funcao(x1);

    if(abs(max(x1-x0))<=tolerancia)
      x0=x1;
      break;
    endif
    x0=x1;
  endfor

  todosx=todosx(:,1:cont);
  todosfx=todosfx(1,1:cont);


##   fprintf("\n%.6f", todosfx);
##   fprintf("\n");
##   fprintf("\n%.6f", todosx);

endfunction


function [x0,cont,todosx,todosfx]=Metodonewton(tolerancia,x0,maxinter)
  alfa=0.425;

  todosx=zeros(2,maxinter);
  todosfx=zeros(1,maxinter);

  for cont=1:maxinter
    x1 = x0 - alfa * inv(hessiana(x0)) * gradient_f(x0);
      todosx(:,cont)=x1;
      todosfx(1,cont)=funcao(x1);
    if(abs(max(x1-x0))<=tolerancia)
      x0=x1;
      break;
    endif
    x0=x1;
  endfor

   todosx=todosx(:,1:cont);
   todosfx=todosfx(1,1:cont);

##   fprintf("\n%.6f", todosfx);
##   fprintf("\n");
## fprintf("\n%.6f", todosx);

endfunction

function f=funcao(x0)
  f = -cos(x0(1)) * cos(x0(2)) * exp(-((x0(1)-pi)^2 + (x0(2)-pi)^2));

endfunction

function h = hessiana(x)
  h= [(-exp(-(-pi + x(1))^2 - (-pi + x(2))^2)*cos(x(2))*((-3 + 4*pi^2 - 8*pi*x(1) + 4*x(1)^2)*cos(x(1)) + 4*(-pi + x(1))*sin(x(1)))), (-2*exp(-(-pi + x(1))^2 - (-pi + x(2))^2)*(-pi + x(2))*cos(x(2))*(2*(-pi + x(1))*cos(x(1)) + sin(x(1))) - exp(-(-pi + x(1))^2 - (-pi + x(2))^2)*(2*(-pi + x(1))*cos(x(1)) + sin(x(1)))*sin(x(2)));
          (-2*exp(-(-pi + x(1))^2 - (-pi + x(2))^2)*(-pi + x(1))*cos(x(1))*(2*(-pi + x(2))*cos(x(2)) + sin(x(2))) - exp(-(-pi + x(1))^2 - (-pi + x(2))^2)*sin(x(1))*(2*(-pi + x(2))*cos(x(2)) + sin(x(2)))), (-exp(-(-pi + x(1))^2 - (-pi + x(2))^2)*cos(x(1))*((-3 + 4*pi^2 - 8*pi*x(2) + 4*x(2)^2)*cos(x(2)) + 4*(-pi + x(2))*sin(x(2))))];
endfunction

function gradiente = gradient_f(x0)
  x=x0(1);
  y=x0(2);
    dx = -cos(x0(2)).*( exp(-x0(1).^2+2.*pi.*x0(1)-2*pi^2-x0(2).^2+2.*pi.*x0(2)) .*cos(x0(1)).*(-2.*x0(1)+2*pi) - exp(-x0(1).^2+2.*pi.*x0(1)-2*pi^2-x0(2).^2+2.*pi.*x0(2)) .*sin(x0(1)) );
    dy = -cos(x0(1)).*( exp(-x0(1).^2+2.*pi.*x0(1)-2*pi^2-x0(2).^2+2.*pi.*x0(2)) .*cos(x0(2)).*(-2.*x0(2)+2*pi) - exp(-x0(1).^2+2.*pi.*x0(1)-2*pi^2-x0(2).^2+2.*pi.*x0(2)) .*sin(x0(2)) );
    gradiente = [dx;dy];
end

function dh=heuclidiana(x0,resultado)
  dh = sqrt((x0(1) - resultado(1))^2 + (x0(2) - resultado(2))^2);
 endfunction


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 function grdficodeconvergencia(todosx,todosfx,cont)
   figure(1);
   subplot(3, 1, 1);
   plot(1:cont,todosx(1,:),'linewidth',1,'color','g');
   set(gca, 'fontsize', 10);
    title('Grafico de convergencia em relacao a x1');
    xlabel('Iteracoes', 'fontsize', 10);
    ylabel('valor de x0', 'fontsize', 10);
    grid on;
   #hold on;
   subplot(3, 1, 2);
   plot(1:cont,todosx(2,:),'linewidth',1,'color','r');
   #hold off;
   set(gca, 'fontsize', 10);
    title('Grafico de convergencia em relacao a x2');
    xlabel('Iteracoes', 'fontsize', 10);
    ylabel('valor de x0', 'fontsize', 10);
    grid on;
    subplot(3, 1, 3);
   plot(1:cont,todosfx(1,:),'linewidth',1,'color','m');
   set(gca, 'fontsize', 10);
    title('Grafico de convergencia em relacao a f(x1,x2)');
    xlabel('Iteracoes', 'fontsize', 10);
    ylabel('valor de x0', 'fontsize', 10);
   grid on;
 endfunction


 ################################################################################



 function geraGraficoFuncao(todosx, todosfx, iter)

  x = -10:0.1:10;
  y = x;
  F = zeros(length(x), length(y), 1);

  for xx = 1:numel(x)
    for yy = 1:numel(y)
      F(xx, yy, 1) = funcao([x(xx); y(yy)]);
    endfor
  endfor

  for cont = 1:iter
    figure(2);
    #subplot(211)
    surf(x, y, F(:, :, 1));
    hold on
    plot3(todosx(2,cont), todosx(1,cont), todosfx(1,cont), 'marker', 'o', 'markersize', 7, 'linewidth', 1, 'color', 'green', 'markerfacecolor', 'green');
    hold off
    set(gca, 'fontsize', 10);
    grid on;
    title(sprintf('Iteracao: %i; f(%.6f, %.6f) = %.6f', cont, todosx(1, cont), todosx(2, cont), todosfx(1, cont)));
    legend('f(x0)', 'solucao atual', 'location', 'northeast');
    xlabel('x1', 'fontsize', 15);
    ylabel('x2', 'fontsize', 15);
    zlabel('f(x1, x2)', 'fontsize', 15);
    pause(0.01);
   endfor

endfunction

