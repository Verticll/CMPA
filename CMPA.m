Is = 0.01*10^-12;
Ib = 0.1*10^-12;
Vb = 1.3;
Gp = 0.1;
V = -1.95:0.0133:0.7;


I = Is * (exp((1.2/0.025) * V) - 1) + Gp*V - Ib * (exp(-(1.2/0.025) * (V + Vb)) - 1);


subplot(3,2,1)
plot(V,I)
title("I vs V of Diode")
xlabel('V')
ylabel('I')
legend('Normal')


subplot(3,2,2)
semilogy(V,abs(I))
title("absolute I vs V of Diode in log")
xlabel('V')
ylabel('I')
legend('Normal')


subplot(3,2,3)
hold on
title("I vs V of Diode with polyfit lines")
xlabel('V')
ylabel('I')
p1 = polyfit(V,I,4);
p2 = polyfit(V,I,8);
p1y = polyval(p1,V);
p2y = polyval(p2,V);
plot(V,I,V,p1y,V,p2y)
hold off
legend('Normal','Polyfit 4th order','Polyfit 8th order')


subplot(3,2,4)
p1 = polyfit(V,I,4);
p2 = polyfit(V,I,8);
p1y = polyval(p1,V);
p2y = polyval(p2,V);
semilogy(V,abs(I))
hold on
semilogy(V,abs(p1y))
semilogy(V,abs(p2y))
title("I vs V in log of Diode with polyfit lines")
xlabel('V')
ylabel('I')
hold off
legend('Normal','Polyfit 4th order','Polyfit 8th order')

%Something is wrong here with the x variable
%fo1 = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');
%ff1 = fit(V,I,fo1);
%If1 = ff1(V);

%subplot(3,2,5)
%hold on
%title("I vs V of Diode with polyfit lines")
%xlabel('V')
%ylabel('I')

%plot(V,I,V,p1y)
%hold off
%legend('Normal','fit A,B,C, and D')

inputs = V.';
targets = I.';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);
view(net)
Inn = outputs;


subplot(3,2,5)
hold on
title("I vs V of Diode with nn")
xlabel('V')
ylabel('I')
plot(V,I,V,Inn)
hold off
legend('Normal','nn')


subplot(3,2,6)
semilogy(V,abs(I))
hold on
semilogy(V,abs(Inn))
title("I vs V in log of Diode with nn")
xlabel('V')
ylabel('I')
hold off
legend('Normal','nn')


