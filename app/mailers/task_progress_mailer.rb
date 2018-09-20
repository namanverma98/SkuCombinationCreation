class TaskProgressMailer < ApplicationMailer

  def task_completion_mail(user)
    mail(:to => user.email, :subject => "Process Completed")
  end
end
