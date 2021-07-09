#!/usr/bin/env python3

import time
import argparse
from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError


def make_request(url):
    request = Request(url)
    try:
        response = urlopen(request)
        text = response.read().decode("utf-8")
    except HTTPError as e:
        print("Server responded with error ", e)
        text = ""
    except URLError as e:
        print("Server not reachable: ", e.reason)
        text = ""

    return text


def parse_args():
    parser = argparse.ArgumentParser(
        description="Traffic balancer tester for vertx-greet service.")
    parser.add_argument("url",
        help="URL to request")
    parser.add_argument("-r", "--requests",
        type=int, default=50, help="Number of requests to send")
    parser.add_argument("-s", "--sleep",
        type=float, default=0.1, help="Time in seconds between each request")

    return parser.parse_args()


def prepare_url(args):
    if not args.url.startswith("http"):
        return f"http://{args.url}"

    return args.url


if __name__ == "__main__":
    requests = 0
    errors = 0
    counters = {
        "Hello World!": 0,
        "Hello Red Hat!": 0,
        "Hello v3!": 0
    }

    args = parse_args()
    url = prepare_url(args)

    print("\033[95mCanary Release Test\033[0m")
    print(f"\033[92mSending {args.requests} requests to {args.url} ...\033[0m\n\n")

    for i in range(args.requests):
        text = make_request(url).strip()
        print(text)
        requests += 1
        if text in counters:
            counters[text] += 1
        else:
            errors += 1

        time.sleep(args.sleep)

    print("\n\n#### Stats ####\n")
    print(f"Total requests: {requests}")

    for key, value in counters.items():
        if value:
            percent = value / requests
            print(f"* '{key}' responses: {value} ({percent * 100}%)")

    errors_percent = errors / requests
    print(f"* Errors: {errors} ({errors_percent * 100}%)")
