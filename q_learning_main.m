close all; clear; clc;

stations = 4;
wait_options = [2,4,6,8,10];
num_waits = length(wait_options);
episodes = 1000;

alpha = 0.5;
gamma = 0.9;

Q = zeros(stations,num_waits);
ExpectedQ = zeros(stations,num_waits);

total_rewards = zeros(episodes,1);
q_error = zeros(episodes,1);

% Pre-calculate theoretical expected rewards
for s = 1:stations
    for a = 1:num_waits
        ExpectedQ(s,a) = calc_expected_reward(s,wait_options(a));
    end
end

% Main training loop 
for ep = 1:episodes
    episode_reward = 0;

    for a = 1:num_waits
        wait_time = wait_options(a);
        
        for s = 1:stations
            reward = simulate_station(s,wait_time);
            
            % Update Q-table
            Q(s,a) = Q(s,a) + alpha*(reward - Q(s,a));
            
            % Clearly display preferred order
            fprintf('Ep %d | Station %c | Wait %2ds | Reward = %6.2f | Q = %6.2f | Expected = %6.2f\n',...
                ep, 'A'+s-1, wait_time, reward, Q(s,a), ExpectedQ(s,a));

            episode_reward = episode_reward + reward;
        end
    end
    
    total_rewards(ep) = episode_reward;
    q_error(ep) = mean(abs(Q(:)-ExpectedQ(:)));
end

% Clearly display final best policy
[~,best_actions] = max(Q,[],2);
disp("Final Best Wait Times per Station:");
for s=1:stations
    fprintf('Station %c → Wait %ds (Learned Q=%.2f | Expected=%.2f)\n',...
        'A'+s-1, wait_options(best_actions(s)),...
        Q(s,best_actions(s)),ExpectedQ(s,best_actions(s)));
end

% Final average rewards (summary table)
final_avg_rewards = zeros(stations,num_waits);
for s=1:stations
    for a=1:num_waits
        rewards=zeros(1,16);
        for t=1:16
            rewards(t)=simulate_station(s,wait_options(a));
        end
        final_avg_rewards(s,a)=mean(rewards);
    end
end

fprintf('\nFinal Avg Rewards for each (Station×WaitTime):\n');
fprintf('%10s','Station\Time');
for a=1:num_waits
    fprintf('%8d s',wait_options(a));
end
fprintf('\n');
for s=1:stations
    fprintf('%10s',['Station ',char('A'+s-1)]);
    for a=1:num_waits
        fprintf('%10.2f',final_avg_rewards(s,a));
    end
    fprintf('\n');
end

% Simple plots (NO heatmap)
figure; plot(total_rewards); grid on;
title('Total Reward per Episode');
xlabel('Episode'); ylabel('Total Reward');

figure; plot(q_error); grid on;
title('Q vs. Expected Error per Episode');
xlabel('Episode'); ylabel('Mean Absolute Error');
