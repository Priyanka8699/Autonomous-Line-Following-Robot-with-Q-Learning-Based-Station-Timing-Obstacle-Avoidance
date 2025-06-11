function expected_reward = calc_expected_reward(station_id,wait_time)

if wait_time<2 || mod(wait_time,2)~=0
    expected_reward=0;return;
end

rewards_data={
    [5,-2,60,-9],[0.05,0.88,0.04,0.03];    % A
    [1,-200,6,50],[0.6,0.3,0.07,0.03];     % B
    [50,-50,100,-100],[0.25,0.25,0.25,0.25];% C
    [0,10,20,30],[0.25,0.35,0.25,0.15];    % D
};

arrival_prob={
    [0.1,0.05,0.04,0.01,0.8];             % A
    [0.7,0.2,0.05,0.04,0.01];             % B
    [0.0125,0.0125,0.95,0.0125,0.0125];   % C
    [0.02,0.03,0.05,0.8,0.1];             % D
};

wait_index=min(wait_time/2,length(arrival_prob{station_id}));
p_arrival=sum(arrival_prob{station_id}(1:wait_index));

rewards=rewards_data{station_id,1};
r_prob=rewards_data{station_id,2};
expected_if_arrived=sum(r_prob.*rewards);

expected_reward=p_arrival*expected_if_arrived;

end
