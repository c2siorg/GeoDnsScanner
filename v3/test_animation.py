import animation
import time

def long_running_function():
    time.sleep(5)
    return

wait = animation.Wait("spinner")
wait.start()
long_running_function()
wait.stop()