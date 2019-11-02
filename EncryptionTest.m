while(true)                                                                 %Creating a prime number p loop
    P = randi([2^3,2^11])*2+1;                                              %Creates random odd number
    isPrime = true;                                                         %Creates a boolean
    count = 0;                                                              %Creates a counting variable that can reset to 0
    while(count<20)                                                         %Use Fermat Theorem to check prime with a loop
        a = randi(2^11);                                                    %Makes random variable a
        z = mod(a*a,P);                                                     %Uses Fermat's Theorem in a loop
        i = 2;
        while i < P-1                                                       %Otherwise Matlab gives overflow error
            z = mod(z*a,P);                                                 %Formula for Fermat Theorem
            i = i+1;
        end
        if z~=1                                                             %Check for prime number in Fermat Theorem
            isPrime = false;                                                %If not prime then break out of loop
            break;
        end
        count = count + 1;                                                  %Iterate count and try again
    end
    if isPrime == true                                                      %If prime number is found then end
        p=P;
        break;                                                              %End loop
    end
end

fprintf('p value is:\t%d\n',p);                                             %Prints out value of p

while(true)                                                                 %Creating a prime number q loop
    Q = randi([2^4,2^11])*2-1;                                               %Creates random odd number
    isPrime = true;                                                         %Creates a boolean
    count = 0;                                                              %Creates a counting variable that can reset to 0
    while(count<20)                                                         %Use Fermat Theorem to check prime with a loop
        a = randi(2^11);                                                     %Makes random variable a
        z = mod(a*a,Q);                                                     %Uses Fermat's Theorem in a loop
        i = 2;                                                              %Otherwise Matlab gives overflow error
        while i < Q-1
            z = mod(z*a,Q);                                                %Formula for Fermat Theorem
            i = i+1;                                                        %Iterate loop
        end
        if z~=1                                                             %Check for prime number in Fermat Theorem
            isPrime = false;                                                %If not prime then break out of loop
            break;
        end
        count = count + 1;                                                  %Iterate count and try again
    end
    if isPrime == true && p~=Q                                              %If prime number is found then end
        q=Q;
        break;                                                              %End loop
    end
end

fprintf('q value is:\t%d\n',q);                                             %Prints out value of q

n = p*q;                                                                    %The value of n
phiN = (p-1)*(q-1);                                                         %The value of phiN

fprintf('n value is:\t%d\n',n);
fprintf('phiN value is:\t%d\n',phiN);

while(true)                                                                 %Loop to encryption key e
    E = randi([2,phiN]);                                                    %Makes random number up to phiN
    GCD = 1==gcd(E,phiN);                                                   %Checks to see if e and phiN are relatively prime
    if(GCD)                                                                 %If so then e is found and can end loop
        e=E;
        break;
    end
end

fprintf('e value is:\t%d\n',e);

x=0;                                                                        %Inital start value of loop
while(true)                                                                 %Loop to find d
    f = 1+x*phiN;                                                           %Possible divident of d
    if 0==mod(f,e)                                                          %Check to see if d is an integer
        d = f/e;                                                            %Save d and end loop
        break;
    end
    x=x+1;                                                                  %If d not found, then iterate again
end

fprintf('d value is:\t%d\n',d);

prompt = 'What message would you like to encrypt?\n';                       %Prompt for user
m = input(prompt,'s');                                                      %Get input message from user
m = double(m);                                                              %Convert input string into double

fprintf('Plaintext:\t%s\n',m);                                              %Check to see if cipher text conversion is correct

c = zeros(1,length(m));                                                     %Create empty array for encrypted text

for i = 1:length(m)                                                         %Loop to encrypt message
    c(i) = m(i);                                                            %Solves c = m^e(mod n) one step at a time
    for j = 2:e                                                             %Does this by doing m*m(mod n) over and over
        c(i) = mod(m(i)*c(i),n);                                            %Until you've multiplied m together e times
    end                                                                     %Then you're left with c
end

fprintf('Ciphertext:\t');                                                   %Print out encrypted text
for i = 1:length(c)                                                         %Prints it out one value after another
    fprintf('%d',c(i));                                                     %Until there are no more left in the array
end

t = zeros(1,length(m));                                                     %Create empty array for decrypted text

for i =1:length(c)                                                          %Loop to decrypt message
    t(i) = c(i);                                                            %Solves m = c^d(mod n) one step at a time
    for j = 2:d                                                             %Does this by doing c*c(mod n) over and over
        t(i) = mod(c(i)*t(i),n);                                            %Until you've multiplied c together e times
    end                                                                     %Then you're left with m
end

fprintf('\nDecrypted text:\t%s\n',t);                                       %Converts decrypted text to letters and prints