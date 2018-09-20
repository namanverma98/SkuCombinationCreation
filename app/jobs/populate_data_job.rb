class PopulateDataJob < ApplicationJob
  require 'sidekiq'
  queue_as do
    if urgent_job?
      :high_priority
    else
      :default
    end
  end

  def perform combinations, user
    combinations.each do |pair|
      #Creating denominations
      Denomination.create(sku_denomination: pair[0], sku_combination: pair[1])
    end
    #Job Completion Mailer
    #Use mailer
    TaskProgressMailer.task_completion_mail(user).deliver_now!
  end

private
  def urgent_job?
    self.arguments.first =~ /\/urgent\//
  end

end
