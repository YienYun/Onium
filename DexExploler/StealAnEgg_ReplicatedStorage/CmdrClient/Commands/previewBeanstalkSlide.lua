-- Script path: ReplicatedStorage.CmdrClient.Commands.previewBeanstalkSlide
-- Decompile time: 0.15 ms

return {
    Name = "previewBeanstalkSlide",
    Description = "Preview the current Beanstalk descent in SAG DEV without rewards. Repeat to restart; true stops your preview.",
    Group = "Admin",
    Args = {{Type = "boolean", Name = "Stop", Optional = true}},
}