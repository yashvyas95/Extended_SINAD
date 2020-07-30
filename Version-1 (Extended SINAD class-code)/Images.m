w = hann(64)
w1 = hamming(64)
w2 = kaiser(64)
w3 = gausswin(64)

plot(w,'-k')
hold on
plot(w1,'-r')
plot(w2,'-m')

plot(w3,'-b')    
legend({'black = Hann Window','red = Hamming Window','Magenta = Kaiser Window','Blue = Gausswin'},'Location','southeast')
hold off