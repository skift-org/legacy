#pragma once

/* Copyright © 2018-2020 N. Van Bossuyt.                                      */
/* This code is licensed under the MIT License.                               */
/* See: LICENSE.md                                                            */

#include <libsystem/Common.h>

struct Notifier;

struct Timer;

void eventloop_initialize(void);

int eventloop_run(void);

void eventloop_pump(void);

void eventloop_exit(int exit_value);

void eventloop_register_notifier(struct Notifier *notifier);

void eventloop_unregister_notifier(struct Notifier *notifier);

void eventloop_register_timer(struct Timer *timer);

void eventloop_unregister_timer(struct Timer *timer);

typedef void (*RunLaterCallback)(void *target);

void eventloop_run_later(RunLaterCallback callback, void *target);

void event_cancel_run_later_for(void *target);

void eventloop_update_timers(void);
