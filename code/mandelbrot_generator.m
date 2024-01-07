function result = mandelbrot_generator(z0, c, n)
    z = z0;
    for i = 1:n
        z = z^2 + c;

        if abs(z) > 1e5
            %disp('invalid');
            break;
        end
    end

    result = z^2 + c;
end