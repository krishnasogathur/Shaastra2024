a_list = -2:0.0005:2;
b_list = -2:0.0005:2;
n = 500;

mandelbrot_set = [];

for a = a_list
    for b = b_list
        c = a + 1i*b;
        z0 = 0;
        z = mandelbrot_generator(z0, c, n);
        if abs(z) < 1e10
            mandelbrot_set = [mandelbrot_set, c];
        end
    end
end

x = real(mandelbrot_set(abs(mandelbrot_set) < 1e1));
y = imag(mandelbrot_set(abs(mandelbrot_set) < 1e1));

plot(x, y, '.');
ylabel('Imaginary');
xlabel('Real');
