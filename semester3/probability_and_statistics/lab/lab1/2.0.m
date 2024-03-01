x=[0:.01:3];
y1=x.^5/10;
y2=x.*sin(x);
y3=cos(x);

subplot(3,1,1);
plot(x,y1, 'b--')
hold on
title("x^5/10")
hold off

subplot(3,1,2);
plot(x, y2, 'g:')
hold on
title("x*sin(x)")
hold off

subplot(3,1,3);
plot(x, y3, 'r')
hold on
title("cos(x)")
hold off