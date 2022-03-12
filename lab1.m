clear all
clc
size=1e6; %number of bits / SNR
data_vector=randi([0, 1], 1,size);%Generating random binary data vector
P=(norm(data_vector)^2)/size %Calculating power of transmitted signal
BER=[];%empty Bit error ratio

for snrdb=0:2:30; %iterating from 0 to 30 step 2
    Rx_sequence = awgn(data_vector,snrdb,'measured');%adding white gaussian noise
    
    %'measured' — The signal level of in is computed to determine the appropriate 
    %noise level based on the value of snr.
    
    new_Rx_sequence=(real(Rx_sequence) >=0.5);%Deciding whether 1 or 0 by comparing with threshold
    [number,ratio] = biterr(data_vector,new_Rx_sequence);%comparing with original bits
    
    BER=[BER ratio];%adding new ratio
end

snrdb=0:2:30;%will be used in semilogy

semilogy(snrdb,BER)
title('BER vs. SNR(dB) ')
ylabel('BER')
xlabel('SNR(dB)')
grid on