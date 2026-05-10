#!/usr/bin/gjs -m
// Fedy entry point - Fedora third-party software installer

import { FedyApplication } from './application.js';
import System from 'system';

const app = new FedyApplication();
app.run([System.programInvocationName].concat(ARGV));
