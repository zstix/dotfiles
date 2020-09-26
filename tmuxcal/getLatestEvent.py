# Periodically fetches the remaining events for today and saves them
# to a txt file for use in tmux (or other scripts).

# Instructions
# 1. Go to https://developers.google.com/calendar/quickstart/python
# 2. Use pip3 to install dependencies
# 3A. Download the credentials from google cloud platform (existing)
# 3B. Click "Enable the Google Calendar API" and follow the steps (new)
# 4. Save `credentisals.json` to the same dir as this script
# 5. Start running scripts (in background) with `python3 getLatestEvetns.py &`

from __future__ import print_function
import datetime
import pickle
import os
import sys
import getopt
import threading
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

SCOPES = ['https://www.googleapis.com/auth/calendar.readonly']
TMP_DIR = '/tmp/tmuxcal'

# Fetch events every 15 min, update next event every 5 min
FETCH_INTERVAL = 60 * 15
UPDATE_INTERVAL = 60 * 5

def get_service():
    creds = None

    if os.path.exists('token.pickle'):
        with open('token.pickle', 'rb') as token:
            creds = pickle.load(token)

    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file('credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        with open('token.pickle', 'wb') as token:
            pickle.dump(creds, token)

    return build('calendar', 'v3', credentials=creds)

def get_event_desc(event):
    start = event['start'].get('dateTime', event['start'].get('date'))
    start_time = datetime.datetime.fromisoformat(start).strftime('%H:%M')
    return start_time + ' ' + event['summary'][0:20]

def get_events():
    service = get_service()

    utcnow = datetime.datetime.utcnow()
    now = utcnow.isoformat() + 'Z'
    eod = utcnow.replace(hour=23, minute=59).isoformat() + 'Z'
    events_result = service.events().list(calendarId='primary', timeMin=now,
            timeMax=eod, maxResults=10, singleEvents=True, orderBy='startTime').execute()
    events = events_result.get('items', [])

    if not events:
        return ["No Events Found"]

    events = map(get_event_desc, events)
    return list(dict.fromkeys(events))

def fetch_and_save_list():
    events = get_events()

    filepath = TMP_DIR + '/list.txt'
    f = open(filepath, 'w')
    for event in events:
        f.write(event + "\n")
    f.close()

def is_after_now(event):
    now = datetime.datetime.now().strftime('%H:%M')
    start = event.split(' ')[0]
    return start > now

def update_list():
    filepath = TMP_DIR + '/list.txt'

    with open(filepath) as f:
        events = [line.rstrip() for line in f]
    updated_events = filter(is_after_now, events)

    f = open(filepath, 'w')
    for event in updated_events:
        f.write(event + "\n")
    f.close()

def fetch_thread():
    thread = threading.Event()
    while not thread.wait(FETCH_INTERVAL):
        fetch_and_save_list()

def update_thread():
    thread = threading.Event()
    while not thread.wait(UPDATE_INTERVAL):
        update_list()

# TODO: better support for background process
def setup_threads():
    t1 = threading.Thread(target=fetch_thread).start()
    t2 = threading.Thread(target=update_thread).start()

def main():
    if not os.path.exists(TMP_DIR):
        os.makedirs(TMP_DIR)

    print(os.path.realpath(__file__))

    if len(sys.argv) == 1:
        setup_threads()
    else:
        opts, args = getopt.getopt(sys.argv[1:], 'fu')
        for opt, arg in opts:
            if opt == '-f':
                fetch_and_save_list()
            elif opt == '-u':
                update_list()

if __name__ == '__main__':
    main()
