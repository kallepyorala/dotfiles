#!/bin/bash
tmux send-keys "nvim" Enter
tmux split-window -h
tmux send-keys "c" Enter
tmux select-pane -L
