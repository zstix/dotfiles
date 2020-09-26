# Instructions
# 1. Go to https://developers.google.com/calendar/quickstart/python
# 2. Use pip3 to install dependencies
# 3A. Download the credentials from google cloud platform (existing)
# 3B. Click "Enable the Google Calendar API" and follow the steps (new)
# 4. Save `credentisals.json` to the same dir as this script
# TODO: steps for running the script

# TODO: color based on proximity
# TODO: run fetch on 15 min interval
# TODO: rename script?

from __future__ import print_function
import datetime
import pickle
import os
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

SCOPES = ['https://www.googleapis.com/auth/calendar.readonly']
TMP_DIR = '/tmp/tmuxcal'

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

    now = datetime.datetime.utcnow().isoformat() + 'Z'
    events_result = service.events().list(calendarId='primary', timeMin=now,
            maxResults=10, singleEvents=True, orderBy='startTime').execute()
    events = events_result.get('items', [])

    if not events:
        return ["No Events Found"]

    events = map(get_event_desc, events)
    return list(dict.fromkeys(events))

def write_list_file(events):
    filepath = TMP_DIR + '/list.txt'
    f = open(filepath, 'w')
    for event in events:
        f.write(event + "\n")
    f.close()

def write_next_file(events):
    filepath = TMP_DIR + '/next.txt'
    f = open(filepath, 'w')
    f.write(events[0])
    f.close()

def main():
    if not os.path.exists(TMP_DIR):
        os.makedirs(TMP_DIR)

    events = get_events()
    write_list_file(events)
    write_next_file(events)

if __name__ == '__main__':
    main()
